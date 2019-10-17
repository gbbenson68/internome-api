#!/bin/bash

ENV_VARS='
PARENT_PID
BASE_URL
'

# Source library functions
THISDIR=$(dirname $0)
RELPATH='../lib/lib_funcs.sh'
if [ -r ${THISDIR}/${RELPATH} ]
then
  . ${THISDIR}/${RELPATH}
else
  printf "\n\t***** ERROR: Library functions not found!\n\n"
  exit 1
fi

# Check for existence of envirnmental variables.
RETVAL=$(check_list "${ENV_VARS}")
if [ ${RETVAL} -eq 0 ]
then
  echo
  echo "***** ERROR: One or more of the following ENVIRONMENTAL VARIABLES not set:"
  echo
  echo "$(list_vars "${ENV_VARS}")"
  echo
  exit 1
fi

# Check for USER_TOKEN tempfile
USER_TOKEN_FILE=${USER_TOKEN_FILENAME_PRE}-${PARENT_PID}.txt
if [ ! -r ${USER_TOKEN_FILE} ]
then
  printf "\n\t***** ERROR: USER_TOKEN temp file not found!\n"
  printf "\t      Please make sure you're signed in first.\n\n"
  exit 1
fi

# Basic usage check.
if [ $# -ne 7 ]
then
  echo
  echo "Usage: $(basename ${0}) <PROFILE_ID> <PROFILE_NAME> <PROFILE_DURATION> <PROFILE_MINTEMPO> <PROFILE_MAXTEMPO> <PROFILE_NUM_INTERVALS> <PROFILE_INTERVAL_TYPE>"
  echo
  echo "     Example: $(basename ${0}) 5da682787044644bb702ec96 'Test Profile' 25 40 120 3 1"
  echo
  exit 1
fi

PROFILE_ID=${1}
PROFILE_NAME=${2}
PROFILE_DURATION=${3}
PROFILE_MINTEMPO=${4}
PROFILE_MAXTEMPO=${5}
PROFILE_NUM_INTERVALS=${6}
PROFILE_INTERVAL_TYPE=${7}
USER_TOKEN=$(cat ${USER_TOKEN_FILE})

# echo "BASE_URL = ${BASE_URL}"
# echo "PROFILE_ID = ${PROFILE_ID}"
# echo "USER_TOKEN = ${USER_TOKEN}"
# echo "PROFILE_NAME = ${PROFILE_NAME}"
# echo "PROFILE_DURATION = ${PROFILE_DURATION}"
# echo "PROFILE_MINTEMPO = ${PROFILE_MINTEMPO}"
# echo "PROFILE_MAXTEMPO = ${PROFILE_MAXTEMPO}"
# echo "PROFILE_NUM_INTERVALS = ${PROFILE_NUM_INTERVALS}"
# echo "PROFILE_INTERVAL_TYPE = ${PROFILE_INTERVAL_TYPE}"

curl "${BASE_URL}/profiles/${PROFILE_ID}" \
  --include \
  --request PATCH \
  --header "Content-Type: application/json" \
  --header "Authorization: Bearer ${USER_TOKEN}" \
  --data '{
    "profile": {
      "name": "'"${PROFILE_NAME}"'",
      "duration": "'"${PROFILE_DURATION}"'",
      "minTempo": "'"${PROFILE_MINTEMPO}"'",
      "maxTempo": "'"${PROFILE_MAXTEMPO}"'",
      "numIntervals": "'"${PROFILE_NUM_INTERVALS}"'",
      "intervalType": "'"${PROFILE_INTERVAL_TYPE}"'"
    }
  }'

echo
