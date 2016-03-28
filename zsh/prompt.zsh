local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

ZSH_THEME_GIT_PROMPT_PREFIX='‹'
ZSH_THEME_GIT_PROMPT_SUFFIX='›'
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[yellow]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}"

git_prompt() {
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
	echo "$(parse_git_dirty)‹${ref#refs/heads/}›%{$reset_color%}"
}

if [[ $UID -eq 0 ]]; then
	local user_host='%{$terminfo[bold]$fg[red]%}%n@%m%{$reset_color%}'
else
	local user_host=''
fi

local current_dir='%{$terminfo[bold]$fg[white]%} %~%{$reset_color%}'
local rvm_ruby=''
if which rvm-prompt &> /dev/null; then
	rvm_ruby='%{$fg[red]%}‹$(rvm-prompt i v g)›%{$reset_color%}'
else
	if which rbenv &> /dev/null; then
		rvm_ruby='%{$fg[red]%}‹$(rbenv version | sed -e "s/ (set.*$//")›%{$reset_color%}'
	fi
fi

#local git_branch='$(git_prompt_info)%{$reset_color%}'
local git_branch='$(git_prompt)'

export VIRTUAL_ENV_DISABLE_PROMPT=yes
local vrt_env=''
if [ $VIRTUAL_ENV ]; then
	vrt_env='%{$fg_bold[cyan]%}‹`basename $VIRTUAL_ENV`›%{$reset_color%}'
fi

local top_prompt_symbol='%{$fg_bold[blue]%}╭─%{$reset_color%}'
local bottom_prompt_symbol='%{$fg_bold[blue]%}╰─ %B$%b%{$reset_color%}'

PROMPT="
${top_prompt_symbol}${user_host}${current_dir} ${git_branch} ${vrt_env}
${bottom_prompt_symbol} "
RPS1="${return_code}"
