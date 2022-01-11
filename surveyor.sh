#!/bin/bash
#
# > Synopsis: A cron script that will survey + notify the status my website up vs down 
# > Origin: 01-08-2022
# > Author Christopher Norman (aloofwolf)
# > Version 1.0 -- 01-09-2022
#       -- 01-09-2022 > Current script is able to send an alert message based on up/down status but can't
#                       stop sending alerts when down status alert is active.

## definitions
# <none-yet>

## variables
SITE_STATUS="up"
C_DATE=$(date '+%a_%b_%d_%T')
ERRS=/tmp/surveyor.$$
PROG=${0##*/}
VER=$(echo $Revision: 1.6 $ |awk '{print$2}')
VERBOSE=off

# dbus-monitor --session interface='org.freedesktop.Notifications'
#--> The dbus-monitor command is used to monitor messages going through a D-Bus message bus.
# this is likely where the solution to the down status alert proliferation issue. 

## plan

#   sed (don't use sed nor awk)
#       > Read the last two characters of the last line from /home/hiro/logs/$PROG.log
#       > IF the last two characters are "UP" 
#           -> [run check site status function]

# look into using Truncate to remove white space and new line at the end of files
# Create /site-surveyor log directory in logs
# create /Site-Surveyor/Daily log directory for daily verbose logs status (up and down)
# Create 2 files for site up status and site down status to be clobbered for each new status
# Create exec logic to check to see which up or down status file is newer
#   -> If down is newer then echo down status into files but do not continue alerting 

## functions
sitetest() {
    if [[ "$SITE_STATUS" -eq "up" ]]; then 
        wget -q --spider www.aloofwolf.com
            if [[ "$?" -eq "1" ]]; then
                $SITE_STATUS="up"
                echo "$C_DATE -- up" >> /home/hiro/logs/$PROG.log
                
            else
                $SITE_STATUS="down"
                echo "$C_DATE -- www.aloofwolf.com is down" >> /home/hiro/logs/$PROG.log
            fi
    fi
}

sitedown-alert() {
    gdbus call --session \
                        --dest=org.freedesktop.Notifications \
                        --object-path=/org/freedesktop/Notifications \
                        --method=org.freedesktop.Notifications.Notify \
                        "" 0 "" 'Alert!' 'www.aloofwolf.com is down' \
                        '[]' '{"urgency": <2>}' 0
}

#site-test-variation() {
#if ! wget -q --spider www.aloofwolf.com; then
#    gdbus call --session \
#        --dest=org.freedesktop.Notifications \
#        --object-path=/org/freedesktop/Notifications \
#        --method=org.freedesktop.Notifications.Notify \
#        "" 0 "" 'Alert!' 'www.aloofwolf.com is down' \
#        '[]' '{"urgency": <2>}' 0
#    echo "$C_DATE -- www.aloofwolf.com is down" >> /home/hiro/logs/$PROG.log
#else
#    echo "$C_DATE -- UP" >> /home/hiro/logs/$PROG.log
#fi
#}



## executioner
sitetest
exit 0

 
