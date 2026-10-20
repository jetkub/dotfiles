autoload -Uz add-zsh-hook
setopt PROMPT_SUBST

# --- Python virtualenv ---
_prompt_venv() {
  _prompt_venv_info=""
  [[ -z $VIRTUAL_ENV ]] && return

  local name
  if [[ -n $VIRTUAL_ENV_PROMPT ]]; then
    name=${VIRTUAL_ENV_PROMPT#\(}
    name=${name%% }
    name=${name%\)}
  else
    name=${VIRTUAL_ENV:t}
  fi
  [[ $name == (.venv|venv) ]] && name=${VIRTUAL_ENV:h:t}

  _prompt_venv_info="%F{244}(${name//\%/%%})%f "
}

# # --- Git ---
# _prompt_git() {
#   _prompt_git_info=""
#
#   local branch
#   branch=$(git symbolic-ref --short HEAD 2>/dev/null) || return  # not a repo / detached
#   branch=${branch//\%/%%}
#
#   local indicators=""
#   git diff --quiet 2>/dev/null          || indicators+="*"
#   git diff --staged --quiet 2>/dev/null || indicators+="+"
#
#   if [[ -z $indicators ]]; then
#     _prompt_git_info=" %F{yellow}(${branch})%f"
#   else
#     _prompt_git_info=" %F{red}(${branch}${indicators})%f"
#   fi
# }

# Try built-in zsh vcs_info instead of custom hook
autoload -Uz vcs_info
zstyle ':vcs_info:*'     enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr '*'
zstyle ':vcs_info:git:*' stagedstr '+'
zstyle ':vcs_info:git:*' formats       ' %m(%b%u%c)%f'
zstyle ':vcs_info:git:*' actionformats ' %m(%b|%a%u%c)%f'

# Reproduce yellow-when-clean / red-when-dirty colouring
zstyle ':vcs_info:git*+set-message:*' hooks dirty-color
+vi-dirty-color() {
  if [[ -n ${hook_com[staged]}${hook_com[unstaged]} ]]; then
    hook_com[misc]='%F{red}'
  else
    hook_com[misc]='%F{yellow}'
  fi
}

add-zsh-hook precmd _prompt_venv
# add-zsh-hook precmd _prompt_git
add-zsh-hook precmd vcs_info

# Static prompt. Single quotes delay expansion until display time.
# PS1='${_prompt_venv_info}%F{$_prompt_color}%n%f%F{253}@%f%F{$_prompt_color}%m%f%F{253}:%f%B%F{74}%2~%f%b${_prompt_git_info} %B%F{79}%% %f%b'
PS1='${_prompt_venv_info}%F{$_prompt_color}%n%f%F{253}@%f%F{$_prompt_color}%m%f%F{253}:%f%B%F{74}%2~%f%b${vcs_info_msg_0_} %B%F{79}%% %f%b'
