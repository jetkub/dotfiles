# Runs for every login shell, including each tmux pane. Must be idempotent:
# on macOS, /etc/zprofile (path_helper) reorders PATH right before this runs.

typeset -gU path fpath   # dedupe; first occurrence wins

# Homebrew setup
[[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

# Homebrew Ruby + latest gems bin (n = numeric sort, [-1] = last match)
# zsh glob qualifiers
# N = Null glob. If no match, expand to nothing instead of throwing error
# / = match directories only
# n = numeric sort instead of lexical
# [-1] = last element of matches
gems_bin=(/opt/homebrew/lib/ruby/gems/*/bin(N/n[-1]))

# Prepend: these come before everything else
path=(
  ~/bin
  ~/.local/bin
  /opt/homebrew/opt/ruby/bin
  $gems_bin
  $path
)
unset gems_bin

# Append: fallbacks only
path+=(
  "/Library/Application Support/org.pqrs/Karabiner-Elements/bin"
  /opt/local/bin /opt/local/sbin   # MacPorts, after Homebrew
  $GOPATH/bin
  /opt/nvim-linux-x86_64/bin
)

# Drop entries that don't exist on this machine.
path=($^path(N-/))
# By default, text attached to array expansion only sticks
# to 1st or last element. e.g.
# arr=(a b c)
# echo $arr.txt    # a b c.txt
#
# ^ = "rc_expand_param" flag: distribute over each element
# echo $^arr.txt   # a.txt b.txt c.txt
#
# So the attached `(N-/)` is appended to every element of `path`
# Each word/element is now a glob pattern with qualifiers.
# Even with no wildcards, zsh still checks the path against the qualifiers.
# N = Null glob.
# - = Follow symlinks when checking the qualifiers that come after it
# / = Must be directory
# So each entry either expands to itself (if it is a directory,
# or a symlink to one) or vanishes.

# SSH agent (useful on Linux; on macOS, launchd already provides SSH_AUTH_SOCK)
[[ -z "$SSH_AUTH_SOCK" ]] && eval "$(ssh-agent)" >/dev/null

# Set preferred editor
if command -v nvim >/dev/null 2>&1; then
  export EDITOR="nvim"
  export NVIM_CFG="$XDG_CONFIG_HOME/nvim"
elif command -v vim >/dev/null 2>&1; then
  export EDITOR="vim"
else
  export EDITOR="vi"
fi

