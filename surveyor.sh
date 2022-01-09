#!/bin/bash
#
# > Synopsis: A cron script that will survey + notify the status my website up vs down 
# > Origin: 01-08-2022
# > Author Christopher Norman (aloofwolf)
# > Version 1.0

## definitions
# <none-yet>

## variables
SYS=$HOSTNAME
C_DATE=$(date '+%a_%b_%d_%T')
ERRS=/tmp/surveyor.$$
PROG=${0##*/}
VER=$(echo $Revision: 1.6 $ |awk '{print$2}')
VERBOSE=off

## functions

#if ! wget -q --spider www.aloofwolf.com; then
#    gdbus call --session \
#        --dest=org.freedesktop.Notifications \
#        --object-path=/org/freedesktop/Notifications \
#        --method=org.freedesktop.Notifications.Notify \
#        "" 0 "" 'Hello world!' 'This is an example notification.' \
#        '[]' '{"urgency": <1>}' 5000
#    echo "$C_DATE -- www.aloofwolf.com is down" >> /home/hiro/logs/$PROG.log
#else
#    echo "$C_DATE -- UP" >> /home/hiro/logs/$PROG.log
#fi

wget -q --spider www.aloofwolf.com

if [[ "$?" != "0" ]]; then
     gdbus call --session \
        --dest=org.freedesktop.Notifications \
        --object-path=/org/freedesktop/Notifications \
        --method=org.freedesktop.Notifications.Notify \
        "" 0 "" 'Alert!' 'www.aloofwolf.com is down' \
        '[]' '{"urgency": <2>}' 0
    echo "$C_DATE -- www.aloofwolf.com is down" >> /home/hiro/logs/$PROG.log
else
    echo "$C_DATE -- UP" >> /home/hiro/logs/$PROG.log
fi

exit 0 
