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
C_DATE=$(date '+%a_%b_%d_')
ERRS=/tmp/surveyor.$$
PROG=${0##*/}
VER=$(echo $Revision: 1.6 $ |awk '{print$2}')
VERBOSE=off

## functions


