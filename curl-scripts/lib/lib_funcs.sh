#!/bin/bash

# Check to see if the given environmental variable exists
check_env_var() {
  var=${1}
  if [ -z $(printenv ${var}) ]
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
