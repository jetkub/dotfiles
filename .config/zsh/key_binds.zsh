# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Builtins
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets

# Use emacs-style key bindings (change to -v for vi-style)
bindkey -e

# Smart history search: type something, then Up/Down to find matching commands
autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "^[[A" up-line-or-beginning-search    # Up arrow
bindkey "^[[B" down-line-or-beginning-search  # Down arrow
bindkey "^P"   up-line-or-beginning-search    # Ctrl+P
bindkey "^N"   down-line-or-beginning-search  # Ctrl+N
# whatever terminfo says
bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
bindkey "${terminfo[kcud1]}" down-line-or-beginning-search

# [Home]/[End]
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

# [Shift-Tab] - move through completion menu backwards
bindkey "^[[Z" reverse-menu-complete

# [Backspace]/[Delete]
bindkey '^?'    backward-delete-char    # Control+Shift+/
bindkey "^[[3~" delete-char             # Delete key

# # [Ctrl-Delete] - delete whole forward-word
# bindkey '^[[3;5~' kill-word
#
# # iTerm2 specific setting
# # set Option+Arrow keys to jump by word if
# # Profiles > Keys > Key Behavior: Opt = Meta
# if [[ "$LC_TERMINAL" == "iTerm2" ]]; then
#   bindkey "^[[1;9C" forward-word   # Option+Right
#   bindkey "^[[1;9D" backward-word  # Option+Left
# fi
#
# bindkey "^[[1;5C" forward-word
# bindkey "^[[1;5D" backward-word
# bindkey "^[[1;3C" forward-word
# bindkey "^[[1;3D" backward-word

# # Set word boundaries
# autoload -Uz select-word-style normal  # default
# autoload -Uz select-word-style bash
#
# WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'  # default
# WORDCHARS='_.-'  # ^W stops at / and :


# Characters (besides letters and digits) that count as part of a word.
typeset -g MY_WORDCHARS='*?_-.~=$&;%(){}<>'
typeset -g MY_WORD_SUFFIX='/'    # may trail a word; deleted with it
typeset -g MY_COARSE_WORDCHARS='_.$-/:~@%+=?&'  # coarse: part of a word

# _mw_len back|fwd <wordchars> <suffixchars>  ->  token length in $REPLY
_mw_len() {
  emulate -L zsh
  local MATCH MBEGIN MEND match mbegin mend
  local wc=${2//-/}; [[ $2 == *-* ]] && wc+='-'
  local sc=${3//-/}; [[ $3 == *-* ]] && sc+='-'
  local word="[[:alnum:]${wc}]" other="[^[:alnum:][:space:]${wc}]" space='[[:space:]]'
  local suffix=''; [[ -n $sc ]] && suffix="[${sc}]*"
  local re
  if [[ $1 == back ]]; then
    re="(${word}+${suffix}|${other}+)${space}*\$|${space}+\$"
    [[ $LBUFFER =~ $re ]] || { REPLY=0; return }
  else
    re="^(${space}*(${word}+${suffix}|${other}+)|${space}+)"
    [[ $RBUFFER =~ $re ]] || { REPLY=0; return }
  fi
  REPLY=${#MATCH}
}

# _mw_move back|fwd <wordchars> <suffixchars>
_mw_move() {
  emulate -L zsh
  _mw_len "$@"
  if [[ $1 == back ]]; then (( CURSOR -= REPLY )); else (( CURSOR += REPLY )); fi
  return 0
}

# _mw_kill back|fwd <wordchars> <suffixchars>
_mw_kill() {
  emulate -L zsh
  _mw_len "$@"
  local len=$REPLY killed
  (( len )) || return 0
  if [[ $1 == back ]]; then
    killed=${LBUFFER: -len}
    LBUFFER=${LBUFFER:0:$(( ${#LBUFFER} - len ))}
  else
    killed=${RBUFFER:0:$len}
    RBUFFER=${RBUFFER:$len}
  fi
  # Emacs-style accumulation across consecutive kills
  if [[ $LASTWIDGET == (fine|coarse)-kill-(back|fwd) ]]; then
    if [[ $1 == back ]]; then CUTBUFFER=$killed$CUTBUFFER
    else CUTBUFFER=$CUTBUFFER$killed; fi
  else
    CUTBUFFER=$killed
  fi
  return 0
}

# Widgets
fine-kill-back()   { _mw_kill back "$MY_WORDCHARS" "$MY_WORD_SUFFIX" }
fine-kill-fwd()    { _mw_kill fwd  "$MY_WORDCHARS" "$MY_WORD_SUFFIX" }
fine-back()        { _mw_move back "$MY_WORDCHARS" "$MY_WORD_SUFFIX" }
fine-fwd()         { _mw_move fwd  "$MY_WORDCHARS" "$MY_WORD_SUFFIX" }

coarse-kill-back() { _mw_kill back "$MY_COARSE_WORDCHARS" '' }
coarse-kill-fwd()  { _mw_kill fwd  "$MY_COARSE_WORDCHARS" '' }
coarse-back()      { _mw_move back "$MY_COARSE_WORDCHARS" '' }
coarse-fwd()       { _mw_move fwd  "$MY_COARSE_WORDCHARS" '' }

for w in fine-kill-back fine-kill-fwd fine-back fine-fwd \
         coarse-kill-back coarse-kill-fwd coarse-back coarse-fwd; do
  zle -N $w
done
unset w

# Kill backward
bindkey '^W'   fine-kill-back       # Ctrl-W: fine
# iTerm2: ⌃<-Del send hex code 0x17 # Ctrl-Backspace: fine
bindkey '^[^?' coarse-kill-back     # Alt-Backspace: coarse

# Kill forward
bindkey '^[[3;5~' fine-kill-fwd    # Ctrl-Delete: fine
bindkey '^[[3;3~' coarse-kill-fwd  # Alt-Delete: coarse

# Move
bindkey '^[[1;5D' fine-back         # Ctrl-Left
bindkey '^[[1;5C' fine-fwd          # Ctrl-Right
bindkey '^[[1;3D' coarse-back       # Alt-Left
bindkey '^[[1;3C' coarse-fwd        # Alt-Right


# Useful editing commands
## Ctrl+r - reverse history search
bindkey '^r' history-incremental-search-backward

## Ctrl+U - delete to start of line
bindkey '^U' backward-kill-line

## Safety feature: pressing Space expands previous command references
## (!!, !$, !<cmd-name>) inline so you can see what you're about to run before
## executing it
bindkey ' ' magic-space

## Alt+w deletes the region between the cursor and the mark.
## Set the mark with Ctrl+Space. Text is added to the kill ring.
## Paste with Ctrl+y.
## Note: ^U, ^K, ^W also add to the kill ring, so ^Y yanks
## the most recent kill from any of them.
bindkey '\ew' kill-region

## Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line  # Ctrl+x Ctrl+e

## Copy previous word
bindkey "^[m" copy-prev-shell-word    # Alt+m
