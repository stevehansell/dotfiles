local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"


collapse_pwd() {
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

set_prompt_symbol_color() {
	if $(command git rev-parse --is-inside-work-tree 2> /dev/null); then
		INDEX=$(command git status --short 2> /dev/null)
		COLOR=""
		if [[ "clean" == $(parse_git_dirty) ]]; then
			COLOR="%{$fg_bold[green]%}"
		fi
		if [[ "dirty" == $(parse_git_dirty) ]]; then
			COLOR="%{$fg_bold[red]%}"
			if [[ -n $(echo "$INDEX" | grep -E '^\?\?') ]]; then
				COLOR="%{$fg_bold[cyan]%}"
			fi
		fi
	else
		COLOR="%{$fg_bold[white]%}"
	fi
	echo $COLOR
}


git_prompt() {
	ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
		ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
	echo "%{$fg[white]%}[⎇ ${ref#refs/heads/}]%{$reset_color%} "
}


export VIRTUAL_ENV_DISABLE_PROMPT=yes
set_pyenv_prompt() {
	if [ $VIRTUAL_ENV ]; then
		echo "%{$fg[white]%}[ξ `basename $VIRTUAL_ENV`]%{$reset_color%} "
	fi
}


set_rbenv_prompt() {
	if which rbenv &> /dev/null; then
		echo "%{$fg[white]%}[♦ $(rbenv version | sed -e "s/ (set.*$//")]%{$reset_color%} "
	fi
}

set_node_prompt() {
	if which node &> /dev/null; then
		echo "%{$fg[white]%}[⬢ $(node --version)]%{$reset_color%} "
	fi
}


background_job_prompt() {
	if [[ $(jobs -l | wc -l) -gt 0 ]]; then
		JOB_PROMPT="%{$fg_bold[yellow]%}❯%{$reset_color%}"
	else
		JOB_PROMPT="$(set_prompt_symbol_color)❯%{$reset_color%}"
	fi
	echo $JOB_PROMPT
}


local current_dir='%{$terminfo[bold]$fg[white]%}$(collapse_pwd)%{$reset_color%}'
local prompt_color='$(set_prompt_symbol_color)'
local prompt_symbol="${prompt_color}❯❯%{$reset_color%}"
local git_branch='$(git_prompt)'
local pyenv_prompt='$(set_pyenv_prompt)'
local rbenv_prompt='$(set_rbenv_prompt)'
local node_prompt='$(set_node_prompt)'
local job_prompt='$(background_job_prompt)'

PROMPT="
${current_dir} ${git_branch}${node_prompt}${rbenv_prompt}
${job_prompt}${prompt_symbol} "

RPS1="${return_code}"
