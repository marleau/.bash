# load user specific environment and startup programs
PATH=$PATH:$HOME/bin:$HOME/.gem/ruby/1.8/bin:/usr/local/cuda/bin
PYTHONPATH=$PYTHONPATH:$HOME/archive/django
export PYTHONPATH
DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/usr/local/cuda/lib

# for rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# autojump
if [ -f `brew --prefix`/etc/autojump ]; then
  . `brew --prefix`/etc/autojump
fi

# get aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

