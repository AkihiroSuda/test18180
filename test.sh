#!/bin/bash
# LICENSE: public domain
set -e

function INFO(){
    echo -e "\e[104m\e[97m[INFO]\e[49m\e[39m $@"
}

INFO 'Checking whether hitting docker#18180.'
for f in $(seq 1 100);do
    taskset 0x1 java 2> /dev/null || true;
    echo -n .;
done
echo
INFO 'OK. not hitting docker#18180.'

INFO 'Checking whether sendfile(2) is killable.'
INFO 'If the container hangs up here, you are still facing the bug that linux@296291cd tried to fix.'
/sendfile-test &
sleep 5
kill -9 $!
wait $!
INFO 'OK. sendfile(2) is killable.'

INFO 'PERFECT!'

