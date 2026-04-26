# Helper func to get macOS bundle id. This is useful if I need to 
# configure Maccy to ignore certain application pasteboards which 
# are identified by their bundle id
get_bundleid() {
	osascript -e "id of app \"$1\""
}

# Overwrite `pass --clip` to fix issue with secrets appearing in
# my clipboard manager Maccy
pass() {
    local clip=0
    for arg in "$@"; do
        if [[ "$arg" == "--clip" || "$arg" == "-c" ]]; then
            clip=1
            break
        fi
    done

    if [[ $clip -eq 1 ]]; then
        defaults write org.p0deje.Maccy ignoreEvents true
        command pass "$@"
        # Fork a background subshell ( ) that waits 2 seconds before
        # re-enabling Maccy. The last `&` backgrounds the subshell so that 
        # control is returned to the terminal immediately and doesn't block. 
        # Here, `&|` backgrounds and *disowns* the job so zsh prints no 
        # "[N] PID" or "[3]  + done" noise.
		(sleep 2 && defaults write org.p0deje.Maccy ignoreEvents false) &|
    else
        command pass "$@"
    fi
}
