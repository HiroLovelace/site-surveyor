#!/bin/bash
#
# > Synopsis: test script for alert notification
# > Author: Christopher Norman (aloofwolf)
# > Origin: 01082022

# > Ver: 1.0 -- 01082022

gdbus call --session \
    --dest=org.freedesktop.Notifications \
    --object-path=/org/freedesktop/Notifications \
    --method=org.freedesktop.Notifications.Notify \
    "" 0 "" 'Alert!' 'aloofwolf.com is currently down' \
    '[]' '{"urgency": <2>}' 0
