# Use subl (Sublime Text cli) from WSL on Windows
_SUBL_PATHS=(
	"/mnt/c/Program Files/Sublime Text/subl.exe"
	"/mnt/c/Program Files (x86)/Sublime Text/subl.exe"
)
for _p in "${_SUBL_PATHS[@]}"; do
	# if exists and executable, set _SUBL_EXE to path of subl.exe
	if [[ -x "$_p" ]]; then
		_SUBL_EXE="$_p"
		break
	fi
done
# clean up
unset _p _SUBL_PATHS

subl() {
	if [[ -z "$_SUBL_EXE" ]]; then
		echo "subl: Sublime Text executable not found" >&2
		return 1
	fi
	local ARGS=()
	for ARG in "$@"; do
		if [[ "$ARG" == -* ]]; then
			ARGS+=("$ARG")
		else
			ARGS+=("$(wslpath -a -w "$ARG")")
		fi
	done
	"$_SUBL_EXE" "${ARGS[@]}"
}

# Run Windows Programs (.exe) from WSL as Fallback without extension
command_not_found_handler() {
	local cmd=$1
	shift

	# Search PATH for .exe, .com, or .bat versions
	local dir
	for dir in ${(s/:/)PATH}; do
		for ext in exe com bat; do
			if [[ -x "$dir/$cmd.$ext" ]]; then
				"$dir/$cmd.$ext" "$@"
				return $?
			fi
		done
	done

	# Fall back to default "command not found" message
	echo "zsh: command not found: $cmd" >&2
	return 127
}

