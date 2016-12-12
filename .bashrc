# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
HISTCONTROL=erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# Combine multiline commands into one in history
shopt -s cmdhist

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Disable beeps
xset b off

# Vi mode
#set editing-mode vi
#set -o vi
#bind -m vi-command -r 'v'

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
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

function hg_dirty ()
{
    hg status --no-color 2> /dev/null \
    | awk '$1 == "?" { unknown = 1 }
           $1 != "?" { changed = 1 }
           END {
             if (changed) printf "!"
             else if (unknown) printf "?"
           }'
}

function rev_branch ()
{
    hg branch 2> /dev/null | awk '{printf "\033[01;31mHG{\033[01;37m"$1"\033[01;31m}"}'
    git branch 2> /dev/null | awk '/^\*/{printf "\033[01;31mGIT{\033[01;37m"$2"\033[01;31m}"}'
}

function cmd_date ()
{
    date +"%T"
}

function user_name ()
{
    whoami 2> /dev/null | \
        awk '$1 == "root" {printf "\033[01;31m"$1}
        $1 != "root" {printf "\033[0m"$1}'
}

function start_line_1 ()
{
    whoami 2> /dev/null | \
        awk '$1 == "root" {printf "\033[1;31m┌╼"}
                $1 != "root" {printf "\[\033[01;36m\]┌╼"}'
}

function start_line_2 ()
{
    whoami 2> /dev/null | \
        awk '$1 == "root" {printf "\n\033[01;31m└─╼"}
                $1 != "root" {printf "\n\[\033[01;36m\]└─╼"}'
}

function error_code()
{
    echo -e " \033[01;31m\${?##0}\033[0m "
}

function prompt_left()
{
    # http://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html
    echo -e "\[\033[01;34m\]┌╼ `user_name`\[\033[0m\]@\h \[\033[01;34m\]\W `rev_branch`\[\033[0m\] \n\[\033[01;34m\]└─╼\[\033[0m\] `cmd_date` \[\033[01;34m\]\[\033[01;34m\]$\[\033[0m\]"
}

function prompt_right()
{
    echo -e "\033[01;35m➤➤➤➤➤➤\033[0m"
}

function prompt_with_colors()
{
    compensate=24
    PS1=$(printf "%*s\r%s " "$(($(tput cols)+${compensate}))" "$(prompt_right)" "$(prompt_left)")
}

if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#	PS1='\[\033[01;34m\]┌╼ `user_name`\[\033[0m\]@\h \[\033[01;34m\]\w `rev_branch`\[\033[0m\]\n\[\033[01;34m\]└─╼\[\033[0m\] `cmd_date` \[\033[01;34m\]$\[\033[0m\] '
    $(prompt_with_colors)
    PROMPT_COMMAND=prompt_with_colors
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
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


export PATH=$PATH:/opt/android-studio/sdk/platform-tools
export PATH=$PATH:$HOME/code/DEBU/repo
export PATH=$PATH:/opt/android-studio-0-8-0/sdk/tools
export PATH=$PATH:/opt/android-ndk-r10c
export PATH=$PATH:$HOME/code/DEBU/scripts
export PATH=$PATH:$HOME/code/lumberjack
export PATH=$PATH:$HOME/code/hourglass


export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/jre

# Use pigmentize with less
export LESS='-R'
export LESSOPEN='|~/.lessfilter %s'
export LESSCOLORIZER=pygmentize

# Powerline for bash, as in vim
# $HOME/powerline/bindings/bash/powerline.sh

export LM_LICENSE_FILE=27005@localhost

source /usr/share/autojump/autojump.sh
