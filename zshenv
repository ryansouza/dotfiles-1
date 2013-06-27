PATH="/usr/local/bin:${PATH}"

_brew_prefix=$(brew --prefix)
PATH="${_brew_prefix}/bin:${_brew_prefix}/sbin:${PATH}"

source ${_brew_prefix}/opt/chruby/share/chruby/chruby.sh

if [ -d "${HOME}/bin" ]; then
    PATH="${HOME}/bin:${PATH}"
fi

typeset -U path
eval "$(hub alias -s)"

PATH="${PATH}:~/bin"

alias reado="\`~/bin/ssh-reagent\`"
