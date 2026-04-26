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
