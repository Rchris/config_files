#!/bin/zsh
# vim: set foldmarker=<<,>> foldlevel=0 foldmethod=marker:
#===================================================================================
#  DESCRIPTION:  You realize, Dr. Angelo, that my intelligence has surpassed yours.
#       AUTHOR:  Jarrod Taylor
#                 .__
#  ________  _____|  |_________   ____
#  \___   / /  ___/  |  \_  __ \_/ ___\
#   /    /  \___ \|   Y  \  | \/\  \___
#  /_____ \/____  >___|  /__|    \___  >
#        \/     \/     \/            \/
#
#===================================================================================
#

PATH="/usr/local/bin:$PATH"

export PATH=$PATH:$HOME/code/lumberjack
export PATH=$PATH:$HOME/code/hourglass

source ~/.bash_aliases

# Source Custom Configurations
for fname in $(find ~/dotfiles/custom-configs -name "*.sh*"); do
    source $fname
done

# Source the prompt
#-------------------------------------------------------------------------------
if [[ ! -n "$ZSHRUN" ]]; then
    source $HOME/.zsh_prompt
fi

# Precmd functions local array variable
#-------------------------------------------------------------------------------
local -a precmd_functions
# Precmd functions
#------------------------------------------------------------------------------
# Run precmd functions so we get our pimped out prompt
#------------------------------------------------------------------------------
precmd_functions=( precmd_prompt )

# Source autojump
#-------------------------------------------------------------------------------
source /usr/share/autojump/autojump.zsh

# General Settings
# Autoload tab completion
#-------------------------------------------------------------------------------
autoload -U compinit
compinit -C
# Modify default zsh directory coloring on ls commands
#-------------------------------------------------------------------------------
export LSCOLORS=gxfxcxdxbxegedabagacad
# Completion settings
#-------------------------------------------------------------------------------
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "$LS_COLORS"
zstyle -e ':completion:*:(ssh|scp|sshfs|ping|telnet|nc|rsync):*' hosts '
    reply=( ${=${${(M)${(f)"$(<~/.ssh/config)"}:#Host*}#Host }:#*\**} )'
# Set the desired setup options man zshoptions
#-------------------------------------------------------------------------------
# If command can't be executed, and command is name of a directory, cd to directory
setopt  auto_cd
# Make cd push the old directory onto the directory stack.
setopt  auto_pushd
# Safety for overwriting files use >| instead of > to over write files
setopt  noclobber
# Prevents aliases on the command line from being internally substituted before
# completion is attempted. The effect is to make the alias a distinct command
# for completion purposes.
setopt  complete_aliases
# Treat the #, ~ and ^ characters as part of patterns for filename
# generation, etc.  (An initial unquoted `~' always produces named directory
# expansion.)
setopt  extended_glob
# If a new command line being added to the history list duplicates an older one,
# the older command is removed from the list (even if it is not the previous event).
setopt  hist_ignore_all_dups
#  Remove command lines from the history list when the first character on the line
#  is a space, or when one of the expanded aliases contains a leading space.
setopt  hist_ignore_space
# This  option  both  imports new commands from the history file, and also
# causes your typed commands to be appended to the history file
setopt  share_history
setopt  noflowcontrol
# When listing files that are possible completions, show the type of each file
# with a trailing identifying mark.
setopt  list_types
# Append a trailing / to all directory names resulting from filename
# generation (globbing).
setopt  mark_dirs
# Perform a path search even on command names with slashes in them.
# Thus if /usr/local/bin is in the user's path, and he or she types
# X11/xinit, the  command /usr/local/bin/X11/xinit will be executed
# (assuming it exists).
setopt  path_dirs
# If set, `%' is treated specially in prompt expansion.
setopt  prompt_percent
# If set, parameter expansion, command substitution and arithmetic
# expansion are performed in prompts.
# Substitutions within prompts do not affect the command status.
setopt  prompt_subst

# History settings
#-------------------------------------------------------------------------------
HISTFILE=$HOME/.zsh_history
HISTFILESIZE=65536  # search this with `grep | sort -u`
HISTSIZE=4096
SAVEHIST=4096
REPORTTIME=60       # Report time statistics for progs that take more than a minute to run
# utf-8 in the terminal, will break stuff if your term isn't utf aware
#-------------------------------------------------------------------------------
export LANG=en_US.UTF-8
export LC_ALL=$LANG
export LC_COLLATE=C

# Set grepoptions
#-------------------------------------------------------------------------------
#export GREP_OPTIONS='--color=auto'

#-------------------------------------------------------------------------------
# Editor and display configurations
#-------------------------------------------------------------------------------
#export EDITOR='vim'
#export VISUAL='vim'
#export GIT_EDITOR=$EDITOR
#export LESS='-imJMWR'
#export PAGER="less $LESS"
#export MANPAGER=$PAGER
#export GIT_PAGER=$PAGER
#export BROWSER='iceweasel'
# Specify virtualenv directories
#-------------------------------------------------------------------------------
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/VirtualDevEnvs

# Eliminate lag between transition from normal/insert mode
#-------------------------------------------------------------------------------
# If this causes issue with other shell commands it can be raised default is 4
export KEYTIMEOUT=1

# Key Bindings
#-------------------------------------------------------------------------------
# Set vi-mode and create a few additional Vim-like mappings
#-------------------------------------------------------------------------------
bindkey -v
bindkey '^R' history-incremental-search-backward
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char

# Aliases
#-------------------------------------------------------------------------------
alias tmux="TERM=screen-256color-bce tmux"  # Fix tmux making vim colors funky
alias ping='ping -c 5'      # Pings with 5 packets, not unlimited
alias delete_pyc='find . -name \*.pyc -exec rm \{\} \+'

# Functions
#===============================================================================

# Memory Usage
#-------------------------------------------------------------------------------
# Shows the specified number of the top memory consuming processes and their PID
#-------------------------------------------------------------------------------
function mem_usage() {
    echo -n "How many you what to see? "; read number
    echo ""
    echo "Mem Size       PID     Process"
    echo "============================================================================="
    if [ "$(uname)" = "Darwin" ]; then
      ps aux | awk '{ output = sprintf("%5d Mb --> %5s --> %s%s%s%s", $6/1024, $2, $11, $12, $13, $14); print output }' | sort -gr | head -n $number
    else
      ps aux | awk '{ output = sprintf("%5d Mb --> %5s --> %s%s%s%s", $6/1024, $2, $11, $12, $13, $14); print output }' | sort -gr | head --line $number
    fi
    }

# Spell Check
#------------------------------------------------------------------------------
# Because, well I need to spell check a lot :\
#------------------------------------------------------------------------------
spell (){
    echo $1 | aspell -a
}

# Run the virtual environments functions for the prompt on each cd
# -------------------------------------------------------------------
#cd() {
#  builtin cd "$@"
#  unset NODE_NAME
#  workon_virtualenv
#  workon_node_env
#}

# Search for running processes
# -------------------------------------------------------------------
any() {
    emulate -L zsh
    unsetopt KSH_ARRAYS
    if [[ -z "$1" ]] ; then
        echo "any - grep for process(es) by keyword" >&2
        echo "Usage: any " >&2 ; return 1
    else
        if [ "$(uname)" = "Darwin" ]; then
            echo "USER            PID     %CPU %MEM VSZ       RSS  TTY   STAT START     TIME    COMMAND"
        else
            echo "USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND"
        fi
        ps xauwww | grep -i --color=auto "[${1[1]}]${1[2,-1]}"
    fi
}

# Display a neatly formatted path
# -------------------------------------------------------------------
path() {
echo $PATH | tr ":" "\n" | \
    awk "{ sub(\"/usr\",   \"$fg_no_bold[green]/usr$reset_color\"); \
           sub(\"/bin\",   \"$fg_no_bold[blue]/bin$reset_color\"); \
           sub(\"/opt\",   \"$fg_no_bold[cyan]/opt$reset_color\"); \
           sub(\"/sbin\",  \"$fg_no_bold[magenta]/sbin$reset_color\"); \
           sub(\"/local\", \"$fg_no_bold[yellow]/local$reset_color\"); \
           print }"
  }

# Displays mounted drive information in a nicely formatted manner
# -------------------------------------------------------------------
function nicemount() {
    (echo "DEVICE PATH TYPE FLAGS" && mount | awk '$2="";1') | column -t ;
}
# Find a file with a pattern in name:
#--------------------------------------------------------------------
function ff() { find . -type f -iname '*'"$*"'*' -ls ; }

# Create an archive (*.tar.gz) from given directory
#--------------------------------------------------------------------
function maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder
#--------------------------------------------------------------------
function makezip() { zip -r "${1%%/}.zip" "$1" ; }


# EOF
