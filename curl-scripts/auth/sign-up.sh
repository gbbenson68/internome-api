#!/bin/bash

ENV_VARS='
USER_EMAIL
USER_PASSWORD
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
  echo "***** ERROR: One or more of the following environmental variables not set:"
  echo
  echo "$(list_vars "${ENV_VARS}")"
  echo
  exit 1
fi

# Basic usage check.
if [ $# -ne 1 ]
then
  echo
  echo "Usage: $(basename ${0}) <BASE_URL>"
  echo
  echo "     Example: $(basename ${0}) http://localhost:4741"
  echo
  exit 1
fi

BASE_URL=${1}
URL_PATH="/sign-up"

# echo "BASE_URL = ${BASE_URL}"
# echo "USER_EMAIL = ${USER_EMAIL}"
# echo "USER_PASSWORD = ${USER_PASSWORD}"

curl "${BASE_URL}${URL_PATH}" \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --data '{
    "credentials": {
      "email": "'"${USER_EMAIL}"'",
      "password": "'"${USER_PASSWORD}"'",
      "password_confirmation": "'"${USER_PASSWORD}"'"
    }
  }'

echo
