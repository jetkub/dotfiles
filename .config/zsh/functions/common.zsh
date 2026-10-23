z_ed_rc()      { $EDITOR $ZDOTDIR/.zshrc; }
z_ed_env()     { $EDITOR $ZDOTDIR/.zshenv; }
z_ed_profile() { $EDITOR $ZDOTDIR/.zprofile; }
z_ed_alias()   { $EDITOR $ZDOTDIR/aliases.zsh; }
z_ed_kb()      { $EDITOR $ZDOTDIR/key_binds.zsh; }

z_reload_shell() {
    echo "Reloading zsh configuration."
    exec zsh -l
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
    grep -irn --color=always "$1" ~/.zshenv $ZDOTDIR |
        grep -Ev "brew_formulae|zsh_history"
}

bin_script() {
    local func_name="$0"
    _bin_script_usage() {
        echo "Moves script to \$HOME/bin"
        echo "  Usage: $func_name <path/to/script>"
    }

    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        _bin_script_usage
        return 0
    fi

    if [[ -z "$1" ]]; then
        _bin_script_usage >&2
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

print_masked_key() {
    local key="$1"
    local len=${#key}

    if [[ -z "$key" ]]; then
        echo "(not set)"
    elif [[ "$len" -le 8 ]]; then
        echo "***"
    else
        echo "${key:0:3}...${key: -3}"
    fi
}
