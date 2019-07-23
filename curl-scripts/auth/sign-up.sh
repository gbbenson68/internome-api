#!/bin/bash

API="http://localhost:4741"
URL_PATH="/sign-up"

curl "${API}${URL_PATH}" \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --data '{
    "credentials": {
      "email": "'"${PROF_EMAIL}"'",
      "password": "'"${PROF_PASSWORD}"'",
      "password_confirmation": "'"${PROF_PASSWORD}"'"
    }
  }'

echo
