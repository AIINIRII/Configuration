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
# shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
# shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
# shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
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

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -l'
alias c='clear'
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
#if ! shopt -oq posix; then
#  if [ -f /usr/share/bash-completion/bash_completion ]; then
#    . /usr/share/bash-completion/bash_completion
#  elif [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#  fi
#fi

GCC_DIR=$HOME/gcc-9.4.0                 # 切换成你自己的gcc地址
GCC_PRE_DIR=$GCC_DIR/gcc-prerequisites      # 切换成你自己的gcc-prerequisites地址

export PATH="$GCC_DIR/bin:$PATH"

export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$GCC_DIR/lib64/"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$GCC_DIR/libexec/"
prelib=($GCC_PRE_DIR/*/lib)
for libpath in ${prelib[@]}; do
  export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$libpath"
done

export CXX="$GCC_DIR/bin/g++"
export CC="$GCC_DIR/bin/gcc"
export LDFLAGS="$LDFLAGS -L $GCC_DIR/lib64"
export LDFLAGS="$LDFLAGS -Wl,-rpath -Wl,$GCC_DIR/lib64"

CMAKE_DIR=$HOME/cmake/
VERSION=3.24.0-rc5
export PATH="$CMAKE_DIR/cmake-$VERSION-linux-x86_64/bin:$PATH"

BOOST_DIR=$HOME/boost/boost
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$BOOST_DIR/lib"
export WITH_BOOST="$BOOST_DIR/include"
export BOOST_ROOT="$HOME/boost/boost"
export BOOST_INCLUDE="$HOME/boost/boost/include"
export BOOST_LIBDIR="$HOME/boost/boost/lib"

ZLIB_DIR=$HOME/zlib
export WITH_ZLIB="$ZLIB_DIR/include"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$ZLIB_DIR/lib"

ROCKSDB_DIR=$HOME/rocksdb-6.22.1
export LD_LIBRARY_PATH="$ROCKSDB_DIR/lib:$LD_LIBRARY_PATH"

LOGSTORE_DIR=$HOME/logstore
export LD_LIBRARY_PATH="$LOGSTORE_DIR/libs:$LD_LIBRARY_PATH"

MYSQL_DIR=$HOME/mysql
export LD_LIBRARY_PATH="$MYSQL_DIR/lib:$LD_LIBRARY_PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/data07/cmt/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/data07/cmt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/data07/cmt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/data07/cmt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

alias cgdb="/home/cmt/softwares/cgdb-0.8.0/bin/cgdb -d /home/cmt/softwares/gdb-9.1/bin/gdb"

