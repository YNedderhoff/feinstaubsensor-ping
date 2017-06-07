#!/bin/bash

CONF=$1
MAIL=$(awk '/^mail/{print $3}' $CONF)
SENSOR=$(awk '/^feinstaubsensor/{print $3}' $CONF)
LOGFILE=$(awk '/^logfile/{print $3}' $CONF)-"$(date +%Y%m%d)".log

ping -c 1 $SENSOR >/dev/null 2>&1
PING=$?

SUBJECT="$SENSOR offline"
FAILMESSAGE="$SENSOR seems to be offline. Status $PING."
SUCCESSMESSAGE="$SENSOR ok, status $PING"

if [ $PING -ne 0 ] ; then 
    echo "$(date +%Y%m%d-%H:%M) $FAILMESSAGE" >> $LOGFILE
    echo "$FAILMESSAGE" | mail -s "$SUBJECT" "$MAIL"
else
    echo "$(date +%Y%m%d-%H:%M) $SUCCESSMESSAGE" >> $LOGFILE
fi
