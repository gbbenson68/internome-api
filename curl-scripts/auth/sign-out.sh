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

URL_PATH="/sign-out"
USER_TOKEN=$(cat ${USER_TOKEN_FILE})

# echo "BASE_URL = ${BASE_URL}"
# echo "USER_TOKEN = ${USER_TOKEN}"

# Perform curl script
curl "${BASE_URL}${URL_PATH}" \
  --include \
  --request DELETE \
  --header "Authorization: Token token=${USER_TOKEN}"

rm -f ${USER_TOKEN_FILE}

echo
