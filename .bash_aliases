#!/bin/bash

if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias grep='grep --color=always'
fi

alias ack="ack-grep -r --color-filename='magenta' --color-line='green' --color-match='bold red'"

alias ll='ls -alF'
alias la='ls -A'
alias lsheader='ls -alF | grep "\.h"'
alias lscpp='ls -alF | grep "\.cpp"'
alias lsgrep='ls -alF | grep '

alias f='find . -iname '

alias man='man -P most'

#alias grep='grep --color=always
alias less='less -R'
alias cat_lexer='pygmentize -l' # followed by lexer and file
#alias pt='pygmentize'

alias diff='colordiff'

alias hg_diff_all='hg st | hg diff | pygmentize -l diff | less'

alias watchdmesg='watch "dmesg | tail -n50"'

alias mc='mc --skin=/usr/share/mc/skins/modarcon16-defbg-chris.ini'

alias memcheck='valgrind --tool=memcheck --track-origins=yes --read-var-info=yes --log-file=valgrind.out '

alias memcheck_xml='valgrind --tool=memcheck --track-origins=yes --read-var-info=yes --log-file=valgrind.out --xml=yes --xml-file=valgrind.xml '

alias clock='tty-clock -n -C 7 -c'

alias lumberjack_adb='lumberjack --config ~/.config/lumberjack/settings/adb_logcat.json'
alias lumberjack_stb='lumberjack --config ~/.config/lumberjack/settings/stb_log.json'

# Expected in purple
# Passed and success in green
# Failed in red
# WARN in in bold blue
# INFO: /i means ignore case
function ctestColor()
{
  sed -u -e 's/.*\bExpected.*/\x1b[0;35m&\x1b[0m/i' \
      -e 's/.*\b*Error:.*/\x1b[0;31m&\x1b[0m/i' \
      -e 's/.*\bPassed.*/\x1b[0;32m&\x1b[0m/' \
      -e 's/.*\bSucces.*/\x1b[0;32m&\x1b[0m/' \
      -e 's/.*\bError:.*/\x1b[0;31m&\x1b[0m/' \
      -e 's/.*\bFailed.*/\x1b[0;31m&\x1b[0m/' \
      -e 's/.*\bBEGINNING.*/\x1b[0;33m&\x1b[0m/' \
      -e 's/.*\bInfo:.*/\x1b[0;34m&\x1b[0m/' \
      -e 's/.*\bWARN.*/\x1b[1;34m&\x1b[0m/'
}

function aptColor()
{
  # TODO: to use it the last line which wait input of the user has to be handled
  sed -u -e 's/.*\bNEW.*/\x1b[0;32m&\x1b[0m/' \
      -e 's/.*\bUPDAT.*/\x1b[0;33m&\x1b[0m/' \
      -e 's/.*\bREMOVE.*/\x1b[1;31m&\x1b[0m/'
}

function sedColor()
{
    color='m'
    style='[0'

    case "$2" in
    [Yy] | [Yy][Ee][Ll][Ll][Oo][Ww] ) color=';33m'
        ;;
    [Rr] | [Rr][Ee][Dd] ) color=';31m'
        ;;
    [Bb] | [Bb][Ll][Uu][Ee] ) color=';34m'
        ;;
    [Gg] | [Gg][Rr][Ee][Ee][Nn] ) color=';32m'
        ;;
    [Cc] | [Cc][Yy][Aa][Nn] ) color=';36m'
        ;;
    [Pp] | [Pp][Uu][Rr][Pp][Ll][Ee] ) color=';35m'
        ;;
   *) color='m'
        ;;
    esac

    case "$3" in
    [Bb] | [Bb][Oo][Ll][Dd] ) style='[1'
        ;;
    [Uu] | [Uu][Nn][Dd][Ee][Rr][Ll][Ii][Nn][Ee] ) style='[4'
        ;;
    *) style='[0'
       ;;
    esac

    sed -u -e 's/.*\b'$1'.*/\x1b'$style''$color'&\x1b[0m/'
}

function replaceAllOccInFiles()
{
    # Start from the current folder

    if [ $# -lt 3 ]
    then
        echo -e "Help:\n"
        echo -e "\$1 old pattern"
        echo -e "\$2 new pattern"
        echo -e "\$3 extension\n"

        echo "Do no forget the escape \ character before the star (\*.txt or \"*.txt\")"
        echo "Use \/ for / in path"
    else
        echo "OLD: "$1
        echo "NEW: "$2
        echo "Ext: "$3
        find . -type f -name "$3" -exec sed -i 's/'$1'/'$2'/g' {} \;
    fi
}

function monitor()
{
  watch -c --no-title "$@"
}

function cthg()
{
   clear;
   hg "$@" -l 15 | sedColor 'dev' yellow bold;
}

function ccthg()
{
   clear;
   hg shortlog -l 30 | sedColor 'dev' yellow | sedColor $1 cyan;
}

function wcthg()
{
  watch -c --no-title cthg
}


function cdls()
{
  cd $1 ; ls
}

function pretty()
{
#  pygmentize -f terminal256 -l text "$1" | less -R
  pygmentize "$1" | less -R
}

function pcpp()
{
  pygmentize -l cpp "$1" | less -R
}

function psh()
{
  pygmentize -l bash "$1" | less -R
}

function p()
{
  pygmentize -l "$1" "$2" | less -R
}

function extract()
{
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1     ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
}

function runCtest()
{
    if [[ -z "$@" ]]; then
        ctest -N
    elif [ "$#" -eq 1 ]; then
        ctest -R $1 -V | ctestColor
    else
        ctest -R $1 -V  --timeout $2 | ctestColor
    fi
}

function rdesktopFull()
{
    rdesktop $1 -u $2 -g 1920x1170 -P -z -x lan -r sound:off
}

function hgdiffkate()
{
    hg diff $1 > tmp.diff && kate tmp.diff
}

function exit_code()
{
    if [ $? -ne 0 ]
    then
        echo "Error: last application failed with exit code not equal to 0 !!"
    fi;
}

function pt()
{
  pygmentize $1 || cat $1
}

function man()
{
    /usr/bin/man $* | col -b | /usr/bin/view -c 'set ft=man nomod nolist' -
}

# or command: alias
alias show_alias='pygmentize -l bash ~/.bash_aliases | less -R'

