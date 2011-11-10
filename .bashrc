# last modified: 2011-09-29_10-34-29

# for cs122b
TOMCAT_HOME=$HOME/archive/UCI/2011-2012_fall/cs122b/apache-tomcat-6.0.33
export TOMCAT_HOME
JRE_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home
export JRE_HOME
CLASSPATH=$CLASSPATH:.:../lib/mysql-connector-java-5.1.17-bin.jar
export CLASSPATH

# aliases
alias ls='ls -lhaGp'
alias c='clear;clear;clear'
alias t='todo.sh -d ~/bin/todo/todo.cfg'
alias jc='javac -Xlint:unchecked'
alias ja='java'
alias r='rails'
alias p='python'
alias p27='python2.7'
alias p3='python3'
alias mvi='mvim'
alias top='top -u'
alias pman='python manage.py'
alias marked='open -a marked'
alias g='git'

# todo.sh autocompletion
_todo() 
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    COMMANDS="add a addto addm append app archive command del  \
              rm depri dp do help list ls listall lsa listcon  \
              lsc listfile lf listpri lsp listproj lsproj move \
              mv prepend prep pri p replace report"

    # Add custom commands from add-ons, if installed. 
    COMMANDS="$COMMANDS $('ls' ${TODO_ACTIONS_DIR:-$HOME/.todo.actions.d}/ 2>/dev/null)"

    OPTS="-@ -@@ -+ -++ -d -f -h -p -P -PP -a -n -t -v -vv -V -x"

    if [ $COMP_CWORD -eq 1 ]; then
	completions="$COMMANDS $OPTS"
    else
	case "${prev}" in
	    -*) completions="$COMMANDS $OPTS";;
	    *)  return 0;;
	esac
    fi

    COMPREPLY=( $( compgen -W "$completions" -- $cur ))
    return 0
}

complete -F _todo todo.sh
# If you define an alias (e.g. "t") to todo.sh, you need to explicitly enable
# completion for it, too: 
complete -F _todo t


# PS1 and PROMPT_COMMAND

# title user@host: current directory
PS1="\[\033]0;\u@\h: \w\007\]"
PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~}\007"'

# current directory
PS1="\[\e]0;\w\007\]"

# Username (if root or remote)
if [ "$(whoami)" = "root" ]; then
    PS1="$PS1\[\e[1;31m\]root"
elif [ -n "$SSH_CLIENT" ]; then
    PS1="$PS1\[\e[1;35m\]\u"
else
    PS1="$PS1\[\e[1;32m\]\u"
fi

# Machine host (if remote)
if [ -n "$SSH_CLIENT" ]; then
    PS1="$PS1@\H"
fi

# current relative directory
PS1="$PS1\[\e[0;32m\]:\W"

# adding git status
if [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
    GIT_PS1_SHOWDIRTYSTATE=1 
    TEMP='$(__git_ps1 "[%s]")'
    PS1="$PS1\[\e[33m\]$TEMP"
fi

# Screen name (if inside a screen)
if [ -n "$STY" ]; then
    PS1=" \[\e[32m\]$STY\[\e[0m\]$PS1"
fi

PS1="$PS1\[\e[32m\] $\[\e[0m\] "

# Display message for failure 
PS1="\`if [ \$? != 0 ]; then echo '\[\e[31m\]실패 '; fi\`\[\e[0m\]$PS1"

