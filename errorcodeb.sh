#!/bin/bash

#function errorcode(){
#    ecode=$(echo $?)
#    tcode=$(echo -e $ecode | toilet -f wideterm)
##    ecode-good=$(echo -e "\033[01;37m[\033[32m👍\033[37m]\033[m")
##    ecode-bad=$(echo -e "\033[01;37m[\033[31m👎 $ecode\033[37m]\033[m")
#    if [ ! $ecode == '0' ]; then
#        echo -en "\033[01;37m[\033[01;31m$tcode\033[01;37m]\033[m ";
#    else
#        echo -en "\033[01;37m[\033[01;32m$tcode\033[01;37m]\033[m ";
#    fi
#    unset ecode tcode
#} 
ps1=$PS1
function nonzero_return() {
    RETVAL=$?
#    RETVALa=[$?]
    echo "$RETVAL"
#   [ $RETVAL -ne 0 ] && echo "$RETVAL"
#    [ $RETVAL -ne 0 ] && echo -en "\033[01;37m[\033[31m$RETVAL\033[37m] \033[m"
    #else
         #echo -e "\033[01;37m[\033[32m$RETVAL\033[37m] \033[m";
    #fi

}


function all_return() {
    RETVAL=$?
    GRETVAL="\033[01;37m[\033[01;32m$RETVAL\033[01;37m] "
    RRETVAL="\033[01;37m[\033[01;31m$RETVAL\033[01;37m] "
    if [ $RETVAL -ne 0 ]; then
         echo -e "$RRETVAL"
    else
         echo -e "$GRETVAL"
    fi
#    [ $RETVAL -ne 0 ] && echo "$RETVAL"
}

export PS1="\n\`nonzero_return\`$ps1"
#export PS1="\n\`all_return\`$ps1"
