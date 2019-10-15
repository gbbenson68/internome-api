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
  echo '           USER_PASSWORD - old user password'
  echo '           USER_PASSWORD_NEW - new user password'
  echo
  exit 1
fi

BASE_URL=${1}
URL_PATH="/sign-out"

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
