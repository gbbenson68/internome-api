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
  echo '           PROF_NAME - name of the profile'
  echo '           PROF_DURATION - profile duration (in seconds)'
  echo '           PROF_MINTEMPO - minimum tempo (in beats per minute)'
  echo '           PROF_MAXTEMPO - in beats per minute'
  echo
  exit 1
fi

BASE_URL=${1}

# echo "BASE_URL = ${BASE_URL}"
# echo "USER_TOKEN = ${USER_TOKEN}"
# echo "PROF_NAME = ${PROF_NAME}"
# echo "PROF_DURATION = ${PROF_DURATION}"
# echo "PROF_MINTEMPO = ${PROF_MINTEMPO}"
# echo "PROF_MAXTEMPO = ${PROF_MAXTEMPO}"

curl "${BASE_URL}/profiles" \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --header "Authorization: Bearer ${USER_TOKEN}" \
  --data '{
    "profile": {
      "name": "'"${PROF_NAME}"'",
      "duration": "'"${PROF_DURATION}"'",
      "minTempo": "'"${PROF_MINTEMPO}"'",
      "maxTempo": "'"${PROF_MAXTEMPO}"'"
    }
  }'

echo
