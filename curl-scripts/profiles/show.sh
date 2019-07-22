#!/bin/sh

if [ $# -ne 1 ]
then
  echo
  echo 'Usage: ${0} <BASE_URL>'
  echo
  echo '  NOTE: Although the BASE_URL is the only variable specified on the command line, the'
  echo '        following variables must also be set in the environment:'
  echo
  echo '           ID - ID of the profile'
  echo '           TOKEN - user authentication token'
  echo
  exit 1
fi

BASE_URL=${1}

# echo "BASE_URL = ${BASE_URL}"
# echo "ID = ${ID}"
# echo "TOKEN = ${TOKEN}"

curl "${BASE_URL}/profiles/${ID}" \
  --include \
  --request GET #\
#  --header "Authorization: Bearer ${TOKEN}"

echo
