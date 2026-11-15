# This is read first, before any other zsh startup files
# It's always read, even for non-interactive shells
# It's read for every shell instance, including scripts
# It's ideal for environment variables that should be available everywhere

# Due to a macOS quirk, PATH modifications should be done in .zprofile instead of .zshenv
# https://apple.stackexchange.com/questions/432226/homebrew-path-set-in-zshenv-is-overridden
# Set variables here that don't get modified by path_helper

# Common env vars
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export GOPATH="$HOME/go"


# macOS-specific
if [[ "$OSTYPE" == "darwin"* ]]; then
    ## Specify the provider library for FIDO/U2F security-key-backed SSH keys.
    # Use secure enclave protected key.
    [[ -f /usr/lib/ssh-keychain.dylib ]] && export SSH_SK_PROVIDER=/usr/lib/ssh-keychain.dylib

    export HOMEBREW_CASK_OPTS="--appdir=~/Applications"
    export BBEDIT_DIR="$HOME/Library/Application Support/BBEdit"

    # `/etc/zshrc` sources `/etc/zshrc_Apple_Terminal` when
    # `TERM_PROGRAM=Apple_Terminal`
    # That script saves per-window state (cwd and separate history per window) so
    # Terminal can restore windows after a restart.
    
    SHELL_SESSION_DIR="$XDG_STATE_HOME/zsh/sessions"

    # machine-specific
    if [[ "$HOST" == "mbpro"* ]]; then
        export LIMA_HOME="$HOME/.lima"
        export MY_PROJECTS="$HOME/Desktop/Projects"
        export MY_NOTES="$HOME/Desktop/Resources/Notes"
        export MY_SCRIPTS="$HOME/Desktop/Projects/Scripts"
        export SCRIPTEDITOR_DIR="$HOME/Library/Mobile Documents/com~apple~ScriptEditor2/Documents"
        export BBEDIT_DIR="$HOME/Library/Mobile Documents/iCloud~com~barebones~bbedit/Documents/Application Support"
    fi
fi

# machine-specific
if [[ "$HOST" == "mbpro*" ]]; then
    export LIMA_HOME="$HOME/.lima"
    export MY_PROJECTS="$HOME/Desktop/Projects"
    export MY_NOTES="$HOME/Desktop/Resources/Notes"
    export MY_SCRIPTS="$HOME/Desktop/Projects/Scripts"
    export SCRIPTEDITOR_DIR="$HOME/Library/Mobile Documents/com~apple~ScriptEditor2/Documents"
    export BBEDIT_DIR="$HOME/Library/Mobile Documents/iCloud~com~barebones~bbedit/Documents/Application Support"
fi


# Linux-specific
if [[ "$OSTYPE" == "linux"* ]]; then
    # fix systemd pager scrollback issues
    export SYSTEMD_LESS=FRSMK
fi
