#!/bin/bash

# USER_TOKEN tempfile prefix
USER_TOKEN_FILENAME_PRE=/tmp/env-internome-api-USER_TOKEN

# Check to see if the given environmental variable exists
check_env_var() {
  var=${1}
  check_var=$(printenv ${var})
  if [ -z "${check_var}" ]
  then
    echo 0
  else
    echo 1
  fi
}

# Check a space-delimited list of environmental variables for existence
check_list() {
  list=${1}
  local retval=1
  for var in ${list}
  do
    retval=$(check_env_var "${var}")
    if [ ${retval} -eq 0 ]
    then
      break
    fi
  done
  echo ${retval}
}

# List the environmental vbariables that should be specified
list_vars() {
  list=${1}
  for var in ${list}
  do
    printf "\t${var}\n"
  done
}

# Get USER_TOKEN from response
get_user_token() {
  return_str="${1}"

  # Derive the check string. I chose to use standard *nix commands here to avoid
  # the need to install a separate JSON parser just for this processing.
  # On first sign-in after sign-up, the token value appears earlier in the string,
  # and therafter later in the string. Hence the if then else statement.
  check_str=$(echo "${return_str}" | cut -d':' -f2 | sed 's/"//g' | sed 's/^{//')

  if [ "${check_str}" = "token" ]
  then
    # First sign-in after sign-up
    echo "${return_str}" | cut -d':' -f3 | sed 's/"//g' | cut -d',' -f1
  else
    # All other sign-ins
    echo "${return_str}" | cut -d':' -f12 | sed 's/"//g' | sed 's/}//g'
  fi
}
