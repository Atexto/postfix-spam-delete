#!/bin/bash
##
## Following script is useful when you need to delete messages from queue but they don't have
## anything common. You can pass the common thing as argument (e.g. X-PHP-Mailer, subject, words, etc.)
## and it will delete all the messages containing the argument.

## usage: ./postfix-spam-delete.sh <common thing>
##

for i in `mailq | tail -n +2 | awk 'BEGIN { RS = "" }{ print $1 }'`; do
        if [[ `/usr/sbin/postcat -q "$i" | grep "$1"` ]]; then
                /usr/sbin/postsuper -d $i
        fi
done
