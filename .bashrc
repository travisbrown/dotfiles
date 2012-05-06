export PATH=$PATH:~/bin:~/.cabal/bin:/opt/java/bin:/opt/jruby/bin
export HISTSIZE=1048576
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=erasedups
export HISTIGNORE="ls:ls *:cd:cd -:pwd:sudo poweroff:date:acpi:sensors"
export JAVA_HOME=/opt/java
export GDK_NATIVE_WINDOWS=1
export GREP_OPTIONS='--color=auto'
export MAVEN_OPTS='-Xmx3G'

[ -z "$PS1" ] && return

. /usr/share/git/completion/git-completion.bash

export PS1='\[\e[1;35m\]\u@\[\e[1;31m\]\h \[\e[1;33m\]\W\[\e[1;34m\]$(__git_ps1 "(%s)")\[\e[0m\]$ '
export MANPAGER="less -X"
export LESS_TERMCAP_md="$ORANGE"

alias ls='ls --color=auto'

function git-change-date()
{
  git filter-branch -f --env-filter 'if [ \$GIT_COMMIT = ${1} ]; then
    export GIT_AUTHOR_DATE="${2}"
    export GIT_COMMITTER_DATE="${2}"
  fi'
}

