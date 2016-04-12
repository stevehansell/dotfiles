local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"


function collapse_pwd {
  local cwd
  if [[ -n $(pwd | grep ^$HOME/Development/ ) ]]; then
    cwd=$(pwd | sed -e "s,^$HOME/Development/,,")
  elif [[ -n $(pwd | grep ^$HOME/talks/ ) ]]; then
    cwd=$(pwd | sed -e "s,^$HOME/talks/,,")
  else
      cwd=$(pwd | sed -e "s,^$HOME,~,")
  fi
  echo "${cwd}"
}

#### LEARNING!

function set_prompt_symbol_color() {
  if $(command git rev-parse --is-inside-work-tree 2> /dev/null); then
		INDEX=$(command git status --short 2> /dev/null)
		COLOR=""
    if [[ "clean" == $(parse_git_dirty) ]]; then
			COLOR="%{$fg_bold[green]%}"
    fi
    if [[ "dirty" == $(parse_git_dirty) ]]; then
			COLOR="%{$fg_bold[red]%}"
			if [[ -n $(echo "$INDEX" | grep -E '^\?\?') ]]; then
				COLOR="%{$fg_bold[magenta]%}"
			fi
		fi
  else
		COLOR="%{$fg_bold[black]%}"
  fi
  echo $COLOR
}


function git_prompt() {
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
	echo "%{$fg_bold[cyan]%}[✭ ${ref#refs/heads/}]%{$reset_color%}"
}


export VIRTUAL_ENV_DISABLE_PROMPT=yes
function set_pyenv_prompt() {
	if [ $VIRTUAL_ENV ]; then
		echo "%{$fg_bold[green]%}[ξ `basename $VIRTUAL_ENV`]%{$reset_color%}"
	fi
}


function set_rbenv_prompt() {
	if which rbenv &> /dev/null; then
		echo "%{$fg_bold[red]%}[♦ $(rbenv version | sed -e "s/ (set.*$//")]%{$reset_color%}"
	fi
}


local current_dir='%{$terminfo[bold]$fg[white]%}$(collapse_pwd)%{$reset_color%}'
local prompt_color='$(set_prompt_symbol_color)'
local prompt_symbol="${prompt_color}❯❯❯%{$reset_color%}"
local git_branch='$(git_prompt)'
local pyenv_prompt="$(set_pyenv_prompt)"
local rbenv_prompt="$(set_rbenv_prompt)"

PROMPT="
${current_dir} ${git_branch} ${pyenv_prompt} ${rbenv_prompt}
${prompt_symbol} "

RPS1="${return_code}"
