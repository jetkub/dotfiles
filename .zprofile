# PATH setup. Use guard (only run if ZPROFILE_LOADED=0)
# to prevent double-execution in complex shell scenarios.
if [[ -z "$ZPROFILE_LOADED" ]]; then
  export ZPROFILE_LOADED=1

  case "$OSTYPE" in
    darwin*)
      # Homebrew setup
      if [[ -x "/opt/homebrew/bin/brew" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      fi

      # Ruby setup with dynamic version detection
      local ruby_base="/opt/homebrew/opt/ruby"
      if [[ -d "$ruby_base/bin" ]]; then
        export PATH="$ruby_base/bin:$PATH"
        # Find latest ruby gems bin dynamically
        local gems_bin=$(find /opt/homebrew/lib/ruby/gems/*/bin -maxdepth 0 2>/dev/null | sort -V | tail -1)
        [[ -n "$gems_bin" && -d "$gems_bin" ]] && export PATH="$gems_bin:$PATH"
      fi

      # Other macOS-specific PATH additions
      [[ -d "/Library/Application Support/org.pqrs/Karabiner-Elements/bin" ]] && \
        export PATH="$PATH:/Library/Application Support/org.pqrs/Karabiner-Elements/bin"

      # MacPorts (add to end to not conflict with Homebrew)
      if [[ -d "/opt/local/bin" ]]; then
        export PATH="$PATH:/opt/local/bin:/opt/local/sbin"
      fi
      ;;

    linux*)
      # Linux-specific PATH modifications
      ;;
  esac

  # Common PATH additions for all platforms
  [[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"
  [[ -d "$HOME/bin" ]] && export PATH="$HOME/bin:$PATH"
  [[ -n "$GOPATH" && -d "$GOPATH/bin" ]] && export PATH="$PATH:$GOPATH/bin"

  # SSH agent setup (only for login shells)
  if [[ -z "$SSH_AUTH_SOCK" ]]; then
    eval $(ssh-agent) >/dev/null 2>&1
  fi
fi

