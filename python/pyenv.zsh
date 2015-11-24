# init according to man page
if (( $+commands[pyenv] ))
then
  eval "$(pyenv init -)"
fi

if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
