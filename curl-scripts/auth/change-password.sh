#!/bin/bash

ENV_VARS='
PARENT_PID
USER_PASSWORD
USER_PASSWORD_NEW
'

# Source library functions
THISDIR=$(dirname $0)
RELPATH='../lib/lib_funcs.sh'
if [ -r ${THISDIR}/${RELPATH} ]
then
  . ${THISDIR}/${RELPATH}
else
  printf "\n\t***** ERROR: Library functions not found!\n\n"
  exit -1
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
  exit -1
fi

# Check for USER_TOKEN tempfile
USER_TOKEN_FILE=${USER_TOKEN_FILENAME_PRE}-${PARENT_PID}.txt
if [ ! -r ${USER_TOKEN_FILE} ]
then
  printf "\n\t***** ERROR: USER_TOKEN temp file not found!\n"
  printf "\t      Please make sure you're signed in first.\n\n"
  exit -1
fi

# Basic usage check.
if [ $# -ne 2 ]
then
  echo
  echo "Usage: $(basename ${0}) <BASE_URL> <0|1>"
  echo
  echo "     Example: $(basename ${0}) http://localhost:4741 0"
  echo
  echo "     The \"swap flag\", when set to 1, swaps the values of USER_PASSWORD"
  echo "     and USER_PASSWORD_NEW, to enable multiple tests to be run with the"
  echo "     same two passwords."
  echo
  exit -1
fi

BASE_URL=${1}
SWAP=${2}
URL_PATH="/change-password"
USER_TOKEN=$(cat ${USER_TOKEN_FILE})

if [ ${SWAP} -eq 1 ]
then
  temp=USER_PASSWORD_NEW
  USER_PASSWORD_NEW=${USER_PASSWORD}
  USER_PASSWORD=${temp}
fi

# echo "BASE_URL = ${BASE_URL}"
# echo "USER_TOKEN = ${USER_TOKEN}"
# echo "USER_PASSWORD = ${USER_PASSWORD}"
# echo "USER_PASSWORD_NEW = ${USER_NEWPASSWD}"

curl "${BASE_URL}${URL_PATH}" \
  --include \
  --request PATCH \
  --header "Authorization: Token token=${USER_TOKEN}" \
  --header "Content-Type: application/json" \
  --data '{
    "passwords": {
      "old": "'"${USER_PASSWORD}"'",
      "new": "'"${USER_PASSWORD_NEW}"'"
    }
  }'

echo
