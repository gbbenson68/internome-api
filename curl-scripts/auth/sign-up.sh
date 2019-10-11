#!/bin/bash

if [ $# -ne 1 ]
then
  echo
  echo 'Usage: ${0} <BASE_URL>'
  echo
  echo '  NOTE: Although the BASE_URL is the only variable specified on the command line, the'
  echo '        following variables must also be set in the environment:'
  echo
  echo '           USER_EMAIL - user email address'
  echo '           USER_PASSWORD - user password'
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
