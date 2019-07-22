#!/bin/bash

if [ $# -ne 1 ]
then
  echo
  echo 'Usage: ${0} <BASE_URL>'
  echo
  echo '  NOTE: Although the BASE_URL is the only variable specified on the command line, the'
  echo '        following variables must also be set in the environment:'
  echo
  echo '           NAME - name of the profile'
  echo '           TOKEN - user authentication token'
  echo '           ID - ID of the profile'
  echo '           DURATION - profile duration (in seconds)'
  echo '           MINTEMPO - minimum tempo (in beats per minute)'
  echo '           MAXTEMPO - in beats per minute'
  echo
  exit 1
fi

BASE_URL=${1}

# echo "BASE_URL = ${BASE_URL}"
# echo "ID = ${ID}"
# echo "NAME = ${NAME}"
# echo "TOKEN = ${TOKEN}"
# echo "DURATION = ${DURATION}"
# echo "MINTEMPO = ${MINTEMPO}"
# echo "MAXTEMPO = ${MAXTEMPO}"

# curl "${BASE_URL}/profiles/${ID}" \
#   --include \
#   --request PATCH \
#   --header "Content-Type: application/json" \
#   --header "Authorization: Bearer ${TOKEN}" \
curl "${BASE_URL}/profiles/${ID}" \
  --include \
  --request PATCH \
  --header "Content-Type: application/json" \
  --data '{
    "profile": {
      "name": "'"${NAME}"'",
      "duration": "'"${DURATION}"'",
      "minTempo": "'"${MINTEMPO}"'",
      "maxTempo": "'"${MAXTEMPO}"'"
    }
  }'

echo
