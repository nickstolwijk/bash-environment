# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1="$RED\$(date +%H:%M) \u@\h:\w$YELLOW \$(__git_ps1)$GREEN\$ "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ -f ~/.bash_profile ]; then
    . ~/.bash_profile
fi

export M2_HOME=/home/nick/apps/apache-maven-3.2.3

mvnrun () {
  echo mvn $@
  eval mvn $@
  echo mvn $@
}

mvnrunwithjvmopts() {
  maven_opts=$MAVEN_OPTS
  export MAVEN_OPTS="-Xmx2048m -Xms1024m -XX:MaxPermSize=512m -Xdebug -Xnoagent -Xrunjdwp:transport=dt_socket,server=y,address=8000,suspend=n -Dcom.sun.management.jmxremote -agentlib:TakipiAgent";
  echo mvn $@
  eval mvn $@
  echo mvn $@
  export MAVEN_OPTS=$maven_opts
}

function gitmassrun () {
    failed=""
    startingdir=`pwd`
    repositories=`find $startingdir -maxdepth 5 -type d -name .git   | xargs -n 1 dirname   | sort`
    echo gitmassrun $@ 
    for i in $repositories; do
       echo $i 
       cd $i
       /usr/bin/git $@ 2>&1 
       status=$?
       if [ $status -ne 0 ]; then
         failed="$failed \n $i"  
       fi
       echo 
    done
    if [ "$failed" ]; then
       echo "Failed projects for command '$@':"
       echo -e "$failed"
    fi
    cd $startingdir
}

gitpushall () {
    startingdir=`pwd`
    for i in $@; do
       cd $i
       /usr/bin/git push
       cd $startingdir 
    done
}
function gitmassco () {
    checkedout=""
    startingdir=`pwd`
    repositories=`find /home/nick/appie/source -type d -name .git   | xargs -n 1 dirname   | sort`
    echo gitmasscheckout $@
    for i in $repositories; do
       echo $i
       cd $i
       /usr/bin/git checkout $@ 2>&1
       status=$?
       if [ $status -eq 0 ]; then
         checkedout="$checkedout \n $i"
       else
         /usr/bin/git checkout master 2>&1
       fi
       echo
    done
    if [ "$checkedout" ]; then
       echo "Checked out the projects:"
       echo -e "$checkedout"
    fi
    cd $startingdir
}

source ~/.mavenrc
