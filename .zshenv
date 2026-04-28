# This is read first, before any other zsh startup files
# It's always read, even for non-interactive shells
# It's read for every shell instance, including scripts
# It's ideal for environment variables that should be available everywhere

# Due to a macOS quirk (https://apple.stackexchange.com/questions/432226/homebrew-path-set-in-zshenv-is-overridden),
# PATH modifications should be done in .zprofile instead of .zshenv
# Set variables here that don't get modified by path_helper
export XDG_CONFIG_HOME="$HOME/.config"
export GOPATH="$HOME/go"
# export COMPLETION_WAITING_DOTS=true

# Set preferred editor
case "$OSTYPE" in
  darwin*) export EDITOR="vim" ;;
  linux*)
    if command -v nvim >/dev/null 2>&1; then
      export EDITOR="nvim"
    elif command -v vim >/dev/null 2>&1; then
      export EDITOR="vim"
    else
      export EDITOR="vi"
    fi ;;
esac

# macOS-specific
if [[ "$OSTYPE" == "darwin"* ]]; then
  export HOMEBREW_CASK_OPTS="--appdir=~/Applications"
  export LIMA_HOME="$HOME/.lima"
  export MY_NOTES="$HOME/Desktop/Resources/Notes"
  export MY_SCRIPTS="$HOME/Desktop/Projects/Scripts"
  export MY_SCRIPTEDITOR_DIR="$HOME/Library/Mobile Documents/com~apple~ScriptEditor2/Documents"
  export MY_BBEDIT_SCRIPTS="$HOME/Library/Mobile Documents/iCloud~com~barebones~bbedit/Documents/Application Support/Scripts"
fi

# Linux-specific
if [[ "$OSTYPE" == "linux"* ]]; then
    # fix systemd pager scrollback issues
    export SYSTEMD_LESS=FRSMK
fi

# wsl-specific (work PC)
if [[ -v WSL_DISTRO_NAME ]] && [[ "$HOST" == *AIW* ]]; then
    # fix Users mount breaking after montly recompose at work
    WINUSER=$(cmd.exe /c echo %username% 2>/dev/null | tr -d '\r\n')
    USERS_MOUNT="/mnt/c/Users/$WINUSER"
    sudo mount -t drvfs "C:/Users/$WINUSER" "$USERS_MOUNT" >/dev/null 2>&1

    # env vars
    export MY_SCRATCH="/mnt/h/Notes/Scratch"
fi
