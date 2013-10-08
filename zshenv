PATH="/usr/local/bin:${PATH}"

_brew_prefix=$(brew --prefix)
PATH="${_brew_prefix}/bin:${_brew_prefix}/sbin:${PATH}"

if [ -d "${HOME}/bin" ]; then
    PATH="${HOME}/bin:${PATH}"
fi

typeset -U path

export GOPATH="$HOME/p/go"
PATH="${PATH}:${GOPATH}/bin"

#This is for homebrew bzr (which I need because of Go, ugh)
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
