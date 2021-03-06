#!/bin/bash

if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias grep='grep --color=always'
fi

# alias ag="ag -r --color-filename='magenta' --color-line='green' --color-match='bold red'"
# alias agi="ag -r --color-filename='magenta' --color-line='green' --color-match='bold red' -i"
# alias ack="ack -r --color-filename='magenta' --color-line='green' --color-match='bold red'"
alias ack="rg"
alias diff="diff --color"
# Cat hightligh
#alias cath="ack --color-filename='magenta' --color-line='green' --color-match='bold red' -i --passthru"
alias cath="rg -i --passthru"

alias ll='ls -alF'
alias lh='ls -alh'
alias la='ls -A'
alias lsheader='ls -alF | grep "\.h"'
alias lscpp='ls -alF | grep "\.cpp"'
alias lsgrep='ls -alF | grep '

alias b='cd ..'
alias i='dpkg -l | grep '
alias f='find . -iname '
alias g='ps aux | grep '
alias p='readlink -f '

alias man='man -P most'

#alias grep='grep --color=always
alias less='less -R'
alias cat_lexer='pygmentize -l' # followed by lexer and file

alias diff='colordiff'

alias hg_diff_all='hg st | hg diff | pygmentize -l diff | less'

alias watchdmesg='watch "dmesg | tail -n50"'

alias memcheck='valgrind --tool=memcheck --track-origins=yes --read-var-info=yes --log-file=valgrind.out '

alias memcheck_xml='valgrind --tool=memcheck --track-origins=yes --read-var-info=yes --log-file=valgrind.out --xml=yes --xml-file=valgrind.xml '

alias clock='tty-clock -n -C 7 -c'

alias make_silent='make -j8 > /dev/null'
alias make_install_silent='make install -j8 > /dev/null'

alias current_spotify='xprop -name "Spotify Premium - Linux Preview" _NET_WM_ICON_NAME | cut -d "-" -f 2 | cut -d "\"" -f 1'

alias adb_nfs='adb shell "/data/local/busybox mount -t nfs -o nolock -o async 192.168.2.1:/srv/nfs /data/local/nfs"'

alias git_origin='git fetch origin ; git checkout origin/master'

alias git_diff='python3 $HOME/scripts/git_diff.py'

alias apep8='find . -path ./virtualenv -prune -o -name "*.py" -exec autopep8 -i -a --max-line-length=100 {} \;'
alias apep8f='autopep8 -i -a --max-line-length=100 '

alias weekly='vi $HOME/Documents/weekly/`date +"%Y"`/weekly_`date +"%U"`.txt'

alias tmux-new='tmux new -s'
alias tmux-attach='tmux -u -CC attach-session -t'
alias tmux-delete='tmux kill-session -t'

# or command: alias
alias show_alias='pygmentize -l bash ~/.bash_aliases | less -R'

# $ type function-name -> to print the function
alias list-functions='grep "function" $HOME/.bash_aliases'

# Expected in purple
# Passed and success in green
# Failed in red
# WARN in in bold blue
# INFO: /i means ignore case
function color()
{
    sed -u -e 's/.*\bCRD.*/\x1b[0;44m&\x1b[0m/' \
           -e 's/.*\bSegmentation.*/\x1b[0;41m&\x1b[0m/I' \
           -e 's/.*\bcore dumped.*/\x1b[0;41m&\x1b[0m/' \
           -e 's/.*\bInfo:.*/\x1b[1;34m&\x1b[0m/I' \
           -e 's/.*\bPassed Tests:.*/\x1b[1;34m&\x1b[0m/I' \
           -e 's/.*\bWarning.*/\x1b[0;33m&\x1b[0m/I' \
           -e 's/.*\bExpected.*/\x1b[0;35m&\x1b[0m/I' \
           -e 's/.*\bError:.*/\x1b[0;31m&\x1b[0m/I' \
           -e 's/.*\b\(ERR\).*/\x1b[0;31m&\x1b[0m/I' \
           -e 's/.*\bundefined reference to.*/\x1b[0;31m&\x1b[0m/' \
           -e 's/.*\bmultiple definition of.*/\x1b[0;31m&\x1b[0m/' \
           -e 's/.*\bPassed Tests.*/\x1b[0;36m&\x1b[0m/I' \
           -e 's/.*\bFailed.*/\x1b[0;31m&\x1b[0m/I' \
           -e 's/.*\bPassed.*/\x1b[0;32m&\x1b[0m/I' \
           -e 's/.*\bSuccess.*/\x1b[0;32m&\x1b[0m/I' \
           -e 's/.*\bBEGINNING.*/\x1b[0;36m&\x1b[0m/' \
           -e 's/.*\bTimeout.*/\x1b[0;33m&\x1b[0m/I' \
           -e 's/.*\bexecuted.*/\x1b[0;94m&\x1b[0m/I' \
           -e 's/.*\bASSERT.*/\x1b[0;33m&\x1b[0m/I' \
           -e 's/.*\bNot Run.*/\x1b[0;33m&\x1b[0m/'
#           -e 's/\*\*\*/\x1b[0;31m&\x1b[0m/' \
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

function highlight-line()
{
    sed -u -e 's/.*\b'$1'.*/\x1b[1;33m&\x1b[0m/'
}

function highlight-rg()
{
    rg --passthru $1
}	

function replace-in-files()
{
    # Start from the current folder

    if [ $# -lt 3 ]
    then
        echo -e "Help:\n"
        echo -e "\$1 old pattern"
        echo -e "\$2 new pattern"
        echo -e "\$3 extension\n"
    else
        echo "OLD: "$1
        echo "NEW: "$2
        echo "Ext: "$3
        find . -type f -name "*.$3" -exec sed -i 's/'$1'/'$2'/g' {} \;
    fi
}

function monitor()
{
  watch -c --no-title "$@"
}

function cl()
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

function extract()
{
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.tar.xz)    xz -d $1       ;;
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
        set -o pipefail ; ctest -R $1 -V | ctestColor
    else
        set -o pipefail ; ctest -R $1 -V  --timeout $2 | ctestColor
    fi
}

function rdesktopFull()
{
    rdesktop $1 -u $2 -g 1920x1170 -P -z -x lan -r sound:off
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

function ftype()
{
    find . -iname "*.$1"
}

function fvi()
{
    find . -iname "$1" -exec vi {} \;
}

function pdf_grep_local()
{
    find . -iname '*.pdf' -exec pdfgrep -n -H "$1" {} \;
}

function for_all_folders()
{
    for d in ./*/ ; do (cd "$d" && pwd && "$@"); done
}

function format_json()
{
    python -m json.tool  $1 >! $1.json
}

function format_xml()
{
    cat $1 | xmllint --format - >! $1.xml
}

function docker_op_id()
{
    docker ps | grep $2 | cut -d" " -f 1 | xargs docker $1
}

function docker_exec_id()
{
    docker ps | grep $1 | cut -d" " -f 1 | xargs -i docker exec -ti {} bash
}

function git-clean ()
{
    git clean -ffdx
    git reset --hard
}

function git_grep_history()
{
    git grep $1 $(git rev-list --all)
}

function update_submodules()
{
    git submodule foreach git clean -xdf
    git submodule foreach git reset --hard

    git submodule init
    git submodule sync --recursive
    git submodule update --recursive --init
}

function view_readme()
{
    pandoc $1 | lynx -stdin
}

function c()
{
    octave-cli --eval "$@"
}
