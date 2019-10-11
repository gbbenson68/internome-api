#!/bin/bash

if [ $# -ne 1 ]
then
  echo
  echo 'Usage: ${0} <BASE_URL>'
  echo
  echo '  NOTE: Although the BASE_URL is the only variable specified on the command line, the'
  echo '        following variables must also be set in the environment:'
  echo
  echo '           USER_TOKEN - user authentication token'
  echo
  exit 1
fi

BASE_URL=${1}
URL_PATH="/sign-out"

# echo "BASE_URL = ${BASE_URL}"
# echo "USER_TOKEN = ${USER_TOKEN}"

curl "${BASE_URL}${URL_PATH}" \
  --include \
  --request DELETE \
  --header "Authorization: Token token=${USER_TOKEN}"

echo
