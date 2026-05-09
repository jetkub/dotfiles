# ---------------------------------------------------------------
# mdf - dotfile subtree helpers
# ---------------------------------------------------------------

# ---------------------------------------------------------------
# Generic subtree helpers (internal)
# ---------------------------------------------------------------
_mdf-subtree-add() {
  local remote="$1"
  local prefix="$2"
  local url="$3"
  local branch="${4:-main}"

  echo "-> Adding remote ${remote} -> ${url}"
  mdf remote add -f "$remote" "$url"

  echo "-> Adding subtree at ${prefix}"
  # subtree resolves prefix relative to working tree root; must be in $HOME
  (cd "$HOME" && mdf subtree add --prefix "$prefix" "$remote" "$branch" --squash)
  if (( $? == 0 )) ; then
    echo "-> Subtree add failed. Rolling back remote ${remote}"
    mdf remote remove "$remote"
    return 1
  fi

  # Store the branch in git config so update-all can read it later
  mdf config "subtree.${remote}.branch" "$branch"
}

_mdf-subtree-update() {
  local remote="$1"
  local prefix="$2"
  local branch
  branch=$(mdf config --get "subtree.${remote}.branch")
  branch="${branch:-main}"

  echo "-> Pulling updates for ${remote} (branch: ${branch})"
  (cd "$HOME" && mdf subtree pull --prefix "$prefix" "$remote" "$branch" --squash)
}

_mdf-subtree-remove() {
  local remote="$1"
  local prefix="$2"

  echo "-> Removing subtree at ${prefix}"
  mdf rm -rf -q "$prefix" # Suppress chatty rm output with `-q`
  mdf commit -m "chore: remove subtree ${prefix}"

  echo "-> Removing remote ${remote}"
  mdf remote remove "$remote"

  # Clean up stored branch metadata
  mdf config --unset "subtree.${remote}.branch"
}

# ---------------------------------------------------------------
# Neovim plugin wrappers
# ---------------------------------------------------------------

# Usage: mdf-nvim-add <plugin-name> <github-url> [branch]
mdf-nvim-add() {
  local name="$1"
  local url="$2"
  local branch="${3:-main}"
  local remote="nvim/${name}"
  local prefix=".config/nvim/pack/plugins/start/${name}"
  local manifest="$HOME/.config/nvim/pack/plugins/plugins.txt"

  if [[ -z "$name" || -z "$url" ]]; then
    echo "Usage: mdf-nvim-add <plugin-name> <github-url> [branch]"
    return 1
  fi

  if mdf remote get-url "$remote" &>/dev/null; then
    echo "Error: '${name}' is already installed. Use mdf-nvim-update to update it."
    return 1
  fi

  if [[ -n $(mdf status --porcelain) ]]; then
    echo "Error: working tree has modifications. Commit or stash changes before adding a plugin."
    return 1
  fi

  _mdf-subtree-add "$remote" "$prefix" "$url" "$branch"

  # Record in manifest for portability
  echo "${name} ${url} ${branch}" >> "$manifest"
  mdf add "$manifest"
  mdf commit --amend --no-edit  # fold into the subtree merge commit
}

# Usage: mdf-nvim-update <plugin-name> 
mdf-nvim-update() {
  local name="$1"
  local remote="nvim/${name}"
  local prefix=".config/nvim/pack/plugins/start/${name}"

  if [[ -z "$name" ]]; then
    echo "Usage: mdf-nvim-update <plugin-name>"
    return 1
  fi

  if ! mdf remote get-url "$remote" &>/dev/null; then
    echo "Error: '${name}' is not installed. Did you run mdf-nvim-add first?"
    return 1
  fi

  _mdf-subtree-update "$remote" "$prefix"
}
 
# Update ALL Neovim plugin subtrees 
mdf-nvim-update-all() {
  local failed=()

  mdf remote -v \
    | awk '/^nvim\// && /\(fetch\)/ {print $1}' \
    | while read -r remote; do
        local name="${remote#nvim/}"
        echo "-> Updating ${name}..."
        mdf-nvim-update "$name" || failed+=("$name")
      done

  if [[ ${#failed[@]} -gt 0 ]]; then
    echo "Warning: failed to update: ${failed[*]}"
  fi
}

# Usage: mdf-nvim-remove <plugin-name>
mdf-nvim-remove() {
  local name="$1"
  local remote="nvim/${name}"
  local prefix=".config/nvim/pack/plugins/start/${name}"
  local manifest="$HOME/.config/nvim/pack/plugins/plugins.txt"

  if [[ -z "$name" ]]; then
    echo "Usage: mdf-nvim-remove <plugin-name>"
    return 1
  fi

  if [[ ! -d "$HOME/$prefix" ]]; then
    echo "Error: ${prefix} does not exist. Is '${name}' the right plugin name?"
    return 1
  fi

  _mdf-subtree-remove "$remote" "$prefix"

  # remove from nvim plugins manifest
  sed -i "/^${name} /d" "$manifest"
  mdf add "$manifest"
  mdf commit --amend --no-edit
}

mdf-nvim-restore() {
  local manifest="$HOME/.config/nvim/pack/plugins/plugins.txt"

  if [[ ! -f "$manifest" ]]; then
    echo "Error: no manifest found at ${manifest}"
    return 1
  fi

  while read -r name url branch; do
    local remote="nvim/${name}"
    if mdf remote get-url "$remote" &>/dev/null; then
      echo "-> ${name} already registered, skipping"
      continue
    fi
    echo "-> Restoring ${name} from ${url} (${branch})"
    mdf remote add -f "$remote" "$url"
    mdf config "subtree.${remote}.branch" "$branch"
  done < "$manifest"
}


# List managed nvim plugins
# alias mdf-nvim-list="mdf remote -v | grep '^nvim/' | grep '(fetch)' | awk '{print \$1, \$2}'"

alias mdf-nvim-list='mdf remote -v | grep "^nvim/" | grep "(fetch)" | awk "{print \$1, \$2}"'

