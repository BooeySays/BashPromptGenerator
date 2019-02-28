#!/bin/bash

themecolor=$(cat theme.clr)
brack_open="$themecolor["
brack_close="$themecolor]"

function nonzero_error(){
    RETVAL=$?
    [ $RETVAL -ne 0 ] && echo -e "$brack_open[31m✕ $RETVAL$brack_close " 
    [ $RETVAL -eq 0 ] && echo -e "$brack_open[32m✓ $RETVAL$brack_close "
}

# get current branch in git repo
function parse_git_branch() {
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ ! "${BRANCH}" == "" ]
    then
        STAT=`parse_git_dirty`
        echo -e "$brack_open[37m${BRANCH}${STAT}$brack_close"
    else
        echo ""
    fi
}

# get current status of git repo

function parse_git_dirty {
    status=`git status 2>&1 | tee`
    dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
    untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
    ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
    newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
    renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
    deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
    bits=''
    if [ "${renamed}" == "0" ]; then
        bits=">${bits}"
    fi
    if [ "${ahead}" == "0" ]; then
        bits="*${bits}"
    fi
    if [ "${newfile}" == "0" ]; then
        bits="+${bits}"
    fi
    if [ "${untracked}" == "0" ]; then
        bits="?${bits}"
    fi
    if [ "${deleted}" == "0" ]; then
        bits="x${bits}"
    fi
    if [ "${dirty}" == "0" ]; then
        bits="!${bits}"
    fi
    if [ ! "${bits}" == "" ]; then
        echo " ${bits}"
    else
        echo ""
    fi
}

export PS1="\n\n$brack_open📂: \033[01;33m\w$brack_close\n$brack_open\033[32mBooeySays\033[37m @ \033[32mDX2$brack_close\n\n\`nonzero_error\`\`parse_git_branch\`[1A\r[37m\$[m "
#export PS1="\n$brack_open📂: \033[01;33m\w$brack_close\n\`nonzero_error\`$brack_open\033[32mBooeySays\033[37m @ \033[32mDX2$brack_close\n[37m\$[m "
#export PS1="\n$brack_open📂: \033[01;33m\w$brack_close\n\`nonzero_error\`\033[37m[\033[32mBooeySays\033[37m@\033[32mDX2\033[37m]\$[m "
#[


#export ps1=$PS1
#export PS1="\n\n\033[2B$ps1 "
