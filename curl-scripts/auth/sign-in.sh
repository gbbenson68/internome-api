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

# Basic usage check.
if [ $# -ne 2 ]
then
  echo
  echo "Usage: $(basename ${0}) <USER_EMAIL> <USER_PASSWORD>"
  echo
  echo "     Example: $(basename ${0}) email@email somepw"
  echo
  exit 1
fi

USER_EMAIL=${1}
USER_PASSWORD=${2}
URL_PATH="/sign-in"

# echo "BASE_URL = ${BASE_URL}"
# echo "USER_EMAIL = ${USER_EMAIL}"
# echo "USER_PASSWORD = ${USER_PASSWORD}"

# Output result to screen and result variable, so we can parse for user token
result=$(curl "${BASE_URL}${URL_PATH}" \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --data '{
    "credentials": {
      "email": "'"${USER_EMAIL}"'",
      "password": "'"${USER_PASSWORD}"'"
    }
  }' | tee /dev/tty)

token_str=$(echo "${result}" | grep '^{')
get_user_token "${token_str}" > ${USER_TOKEN_FILENAME_PRE}-${PARENT_PID}.txt

echo
