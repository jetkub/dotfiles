# Start timing. Comment PROMPT_TIMING to disable. -v checks if variable is set.
#PROMPT_TIMING=true
if [[ -v PROMPT_TIMING ]]; then
    PROMPT_START_TIME=$(($(date +%s%N)/1000000)) # DEBUG
fi

# zsh configuration directories
export ZDOTDIR="$HOME/.zsh"
export ZSH_CACHE_DIR="$ZDOTDIR/cache"

# SAVEHIST is the maximum number of events to save in the HISTFILE
# HISTSIZE is maximum number of events to store in the internal history list
export SAVEHIST=400000
export HISTSIZE=500000
export HISTFILE="$ZDOTDIR/zsh_history"

# zsh options
setopt interactivecomments
setopt inc_append_history_time
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_ignore_dups
setopt hist_expire_dups_first
setopt extended_history

# Prompt
source "$ZDOTDIR/zsh_prompt"
#PS1="%F{red}%n%f%F{253}@%f%F{red}%m%f%F{253}:%f%B%F{74}%2~%f%b %B%F{79}%% %f%b"

case $HOST in
    mbpro*|Mac*)    _prompt_color='red' ;;
    dawn*)          _prompt_color='027' ;;
    dusk*)          _prompt_color='green' ;;
    *)              _prompt_color='blue' ;;
esac

precmd() {
  local git_info=$(git_prompt_info)
  PS1="%F{$_prompt_color}%n%f%F{253}@%f%F{$_prompt_color}%m%f%F{253}:%f%B%F{74}%2~%f%b${git_info} %B%F{79}%% %f%b"
}

# Create cache and completions dir and add to $fpath
mkdir -p "$ZSH_CACHE_DIR/completions"
(( ${fpath[(Ie)$ZSH_CACHE_DIR/completions]} )) || fpath=("$ZSH_CACHE_DIR/completions" $fpath)

# Enable homebrew completions
# Set FPATH so that zsh can find homebrew completions
# Only add if not already present
if command -v brew >/dev/null 2>&1; then
  local brew_completions="$(brew --prefix)/share/zsh-completions"
  if [[ "$FPATH" != *"$brew_completions"* ]]; then
    FPATH="$brew_completions:$FPATH"
  fi
fi

# Initialize completions
autoload -Uz compinit && compinit
# Load bash completion compatibility (for tools that only provide bash completions)
autoload -Uz bashcompinit && bashcompinit


# Load configuration modules
source "$ZDOTDIR/zsh_completions"
source "$ZDOTDIR/zsh_aliases"
source "$ZDOTDIR/zsh_key_binds"


# Platform-specific integrations
# iTerm2
if [[ "$LC_TERMINAL" == "iTerm2" ]]; then
    [[ -f "$HOME/.iterm2_shell_integration.zsh" ]] && source "$HOME/.iterm2_shell_integration.zsh"
fi

# Load universal functions
z_ed_rc()      { $EDITOR ~/.zshrc; }
z_ed_env()     { $EDITOR ~/.zshenv; }
z_ed_profile() { $EDITOR ~/.zprofile; }
z_ed_alias()   { $EDITOR ~/.zsh/zsh_aliases; }
z_ed_kb()      { $EDITOR ~/.zsh/zsh_key_binds; }

source ~/.zsh/zsh_functions/common.zsh

# Load macOS-specific functions
if [[ "$OSTYPE" == "darwin"* ]]; then
  source ~/.zsh/zsh_functions/macos.zsh
fi

# Load WSL-specific functions
if [[ -v WSL_DISTRO_NAME ]]; then
  source ~/.zsh/zsh_functions/wsl.zsh
fi

# Prompt benchmarking. Uncomment PROMPT_TIMING to use.
if [[ -v PROMPT_TIMING ]]; then
    # End timing and display
    PROMPT_END_TIME=$(($(date +%s%N)/1000000)) # DEBUG
    echo "Prompt load time: $((PROMPT_END_TIME - PROMPT_START_TIME))ms"
fi
