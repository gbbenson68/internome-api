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
if [ $# -ne 1 ]
then
  echo
  echo "Usage: $(basename ${0}) <PROFILE_ID>"
  echo
  echo "     Example: $(basename ${0}) 5da681347044644bb702ec95"
  echo
  exit 1
fi

PROFILE_ID=${1}
USER_TOKEN=$(cat ${USER_TOKEN_FILE})

# echo "BASE_URL = ${BASE_URL}"
# echo "USER_TOKEN = ${USER_TOKEN}"
# echo "PROFILE_ID = ${PROFILE_ID}"

curl "${BASE_URL}/profiles/${PROFILE_ID}" \
  --include \
  --request DELETE \
  --header "Authorization: Bearer ${USER_TOKEN}"

echo
