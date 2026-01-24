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

# Load configuration modules
source "$ZDOTDIR/zsh_completions"
source "$ZDOTDIR/zsh_aliases"
source "$ZDOTDIR/zsh_key_binds"


# Platform-specific integrations
# iTerm2
if [[ "$LC_TERMINAL" == "iTerm2" ]]; then
    [[ -f "$HOME/.iterm2_shell_integration.zsh" ]] && source "$HOME/.iterm2_shell_integration.zsh"
fi

# Functions for interactive sessions
z_ed_rc()      { $EDITOR ~/.zshrc; }
z_ed_env()     { $EDITOR ~/.zshenv; }
z_ed_profile() { $EDITOR ~/.zprofile; }
z_ed_alias()   { $EDITOR ~/.zsh/zsh_aliases; }
z_ed_kb()      { $EDITOR ~/.zsh/zsh_key_binds; }

z_reload_shell() {
    echo "Reloading zsh configuration..."
    source ~/.zshenv
    [[ -f ~/.zprofile ]] && source ~/.zprofile
    source ~/.zshrc
    # rebuild command completion hash table
    rehash
    echo "Done."
}

extract_tar() {
    if [ -f "$1" ]; then
        dirname="${1%%.*}"
        mkdir -p "$dirname"
        tar -xf "$1" -C "$dirname"
        echo "Extracted $1 to $dirname/"
    else
        echo "File not found: $1"
    fi
}

z_search_conf() {
    if [ -z "$1" ]; then
        echo "Usage: $0 <search_pattern>"
        return 1
    fi

    # Search for the pattern and color the output
    grep -irn --color=always "$1" ~/.zshenv ~/.zshrc ~/.zprofile ~/.zsh/zsh* |
    grep -Ev "brew_formulae|zsh_history"
}

# overwrite rsync to exclude macOS cruft
rsync() {
    local exclude_file="$HOME/.rsync/exclude"
    if [[ -f "$exclude_file" ]]; then
        command rsync --exclude-from="$exclude_file" "$@"
    else
        command rsync --exclude=.DS_Store "$@"
    fi
}

get_bundleid() {
    case "$OSTYPE" in
        darwin*)
            osascript -e "id of app \"$1\"" ;;
        *)
            echo "Unsupported OS" >&2
            return 1 ;;
    esac
}

bin_script() {
    if [ -z "$1" ]; then
        echo "Usage: $0 <search_pattern>"
        return 1
    fi
    cp -f "$1" "$HOME/bin"
    echo "Deployed $1 to ~/bin"
}

print_term_col() {
	for i in {0..255}; do
		print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}
	done
}

if [[ -v PROMPT_TIMING ]]; then
    # End timing and display
    PROMPT_END_TIME=$(($(date +%s%N)/1000000)) # DEBUG
    echo "Prompt load time: $((PROMPT_END_TIME - PROMPT_START_TIME))ms"
fi
