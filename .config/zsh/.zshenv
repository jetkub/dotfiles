# This is read first, before any other zsh startup files
# It's always read, even for non-interactive shells
# It's read for every shell instance, including scripts
# It's ideal for environment variables that should be available everywhere

# Due to a macOS quirk (https://apple.stackexchange.com/questions/432226/homebrew-path-set-in-zshenv-is-overridden),
# PATH modifications should be done in .zprofile instead of .zshenv
# Set variables here that don't get modified by path_helper
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export GOPATH="$HOME/go"

# Common env vars
# ...


# macOS-specific
if [[ "$OSTYPE" == "darwin"* ]]; then
  export HOMEBREW_CASK_OPTS="--appdir=~/Applications"
  export LIMA_HOME="$HOME/.lima"
  export MY_PROJECTS="$HOME/Desktop/Projects"
  export MY_NOTES="$HOME/Desktop/Resources/Notes"
  export MY_SCRIPTS="$HOME/Desktop/Projects/Scripts"
  export SCRIPTEDITOR_DIR="$HOME/Library/Mobile Documents/com~apple~ScriptEditor2/Documents"
  export BBEDIT_SCRIPTS="$HOME/Library/Mobile Documents/iCloud~com~barebones~bbedit/Documents/Application Support/Scripts"

  # `/etc/zshrc` sources `/etc/zshrc_Apple_Terminal` when
  # `TERM_PROGRAM=Apple_Terminal`
  # That script saves per-window state (cwd and separate history per window) so
  # Terminal can restore windows after a restart.
  SHELL_SESSION_DIR="$XDG_STATE_HOME/zsh/sessions"
fi


# Linux-specific
if [[ "$OSTYPE" == "linux"* ]]; then
    # fix systemd pager scrollback issues
    export SYSTEMD_LESS=FRSMK
fi
