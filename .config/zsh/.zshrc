# --- DEBUG: Prompt benchmarking ---
# Start timing. Comment PROMPT_TIMING to disable. -v checks if variable is set.
# PROMPT_TIMING=true
[[ -v PROMPT_TIMING ]] && { zmodload zsh/datetime; _zsh_start=$EPOCHREALTIME }


# --- General config ---

export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"
[[ -d "$ZSH_CACHE_DIR/completions" ]] || mkdir -p "$ZSH_CACHE_DIR/completions"

# SAVEHIST is the maximum number of events to save in the HISTFILE
# HISTSIZE is maximum number of events to store in the internal history list
SAVEHIST=400000
HISTSIZE=500000
HISTFILE="$XDG_STATE_HOME/zsh/history"
[[ -d "${HISTFILE:h}" ]] || mkdir -p "${HISTFILE:h}"

# zsh options
setopt interactivecomments
setopt inc_append_history_time
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_ignore_dups
setopt hist_expire_dups_first
setopt extended_history


# --- Prompt config ---

# disable Python venv prompt; handle in $ZDOTDIR/prompt.zsh
export VIRTUAL_ENV_DISABLE_PROMPT=1

case $HOST in
    mbpro*|Mac*)    _prompt_color='red' ;;
    dawn*)          _prompt_color='027' ;;
    dusk*)          _prompt_color='green' ;;
    *)              _prompt_color='blue' ;;
esac

source "$ZDOTDIR/prompt.zsh"


# --- Set up completions ---

typeset -gU fpath

# Add cache/completions dir to $fpath
(( ${fpath[(Ie)$ZSH_CACHE_DIR/completions]} )) || fpath=("$ZSH_CACHE_DIR/completions" $fpath)

# Enable homebrew completions
# Set fpath so that zsh can find homebrew completions
[[ -n $HOMEBREW_PREFIX ]] && fpath=("$HOMEBREW_PREFIX/share/zsh-completions" $fpath)


# Initialize completions
autoload -Uz compinit && compinit -d "$ZSH_CACHE_DIR/zcompdump"
# set cache directory, otherwise .zcompdump lands in $ZDOTDIR

# Load bash completion compatibility (for tools that only provide bash completions)
autoload -Uz bashcompinit && bashcompinit


# --- Plugin manager ---
#
# to fix "(eval):325: command not found: compdef",
# load `antidote` _after_ running compinit.
#
# Caveat: Antidote's docs suggest `autoload -Uz compinit &&
# compinit` after loading plugins, but that only works if no
# plugin calls compdef while loading. Running it first is safer.
# The one catch is that plugins which add completion directories
# to fpath (like zsh-users/zsh-completions) must be on fpath
# before compinit. If adding that type of plugin later, either
# add its directory to fpath manually before compinit, or use
# antidote's attmc3/ez-compinit bundle, which its docs list for
# this purpose

source "$ZDOTDIR/.antidote/antidote.zsh"

[[ -f $ZDOTDIR/.zsh_plugins.txt ]] || touch "$ZDOTDIR/.zsh_plugins.txt"

export ANTIDOTE_HOME="${XDG_CACHE_HOME:-$HOME}/.antidote"

# initialize plugins statically with $ZDOTDIR/.zsh_plugins.txt
antidote load


# --- Load config modules ---

source "$ZDOTDIR/completions.zsh"
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/key_binds.zsh"


# --- Set up tools ---

# fzf
# key bindings (^R, ^T, Alt-C) and ** completion
if (( $+commands[fzf] )); then
  if ! source <(fzf --zsh) 2>/dev/null; then
    for dir in /opt/homebrew/opt/fzf/shell /usr/share/doc/fzf/examples /usr/share/fzf; do
      [[ -f $dir/key-bindings.zsh ]] || continue
      source $dir/key-bindings.zsh
      source $dir/completion.zsh 2>/dev/null
      break
    done
    unset dir
  fi
fi


# az
# cli completions
if (( $+commands[az] )) && [[ -v WSL_DISTRO_NAME ]]; then
    source /etc/bash_completion.d/azure-cli
fi


# iTerm2
if [[ "$LC_TERMINAL" == "iTerm2" ]]; then
    [[ -f "$HOME/.iterm2_shell_integration.zsh" ]] && source "$HOME/.iterm2_shell_integration.zsh"
fi


# --- Load custom functions ---

source $ZDOTDIR/functions/common.zsh
source $ZDOTDIR/functions/mdf-helpers.zsh

# Load macOS-specific functions
if [[ "$OSTYPE" == "darwin"* ]]; then
  source $ZDOTDIR/functions/macos.zsh
fi

# Load WSL-specific functions
if [[ -v WSL_DISTRO_NAME ]]; then
  source $ZDOTDIR/functions/wsl.zsh
fi


# --- Prompt benchmarking ---

# Uncomment PROMPT_TIMING to use.
[[ -v PROMPT_TIMING ]] && printf 'Startup time: %.0fms\n' $(( (EPOCHREALTIME - _zsh_start) * 1000 ))
