#!/bin/bash
# LICENSE: public domain
set -e

function INFO(){
    echo -e "\e[104m\e[97m[INFO]\e[49m\e[39m $@"
}

function dokillkill () {
  sleep 5;
  kill -9 ${1}
  return ${?}
}

_e=0

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
_e=${?};
if [ ${_e} -ne 0 ]; then
  INFO "Error(${?}) failed to run /sendfile-test in background"
  exit ${_e}
else
  _bpid="${!}"
  _dvs="$( date )"
  dokillkill "${_bpid}" &
  _e=${?};
  if [ ${_e} -ne 0 ]; then
    INFO "Error(${?}) failed to run DOKILLKILL ${_bpid} in background"
    kill -9 ${_bpid}
    exit ${_e};
  else
    _kpid=${!}
    if wait ${_bpid}; then
      _e=${?}
    else
      _e=${?}
    fi
    _dve="$( date )"
    INFO "OK. sendfile(2) is killable when ( ${_dve} - ${_dvs}  => 5s ) and exit code ${_e} != 0."
  fi
fi
