#!/bin/bash

# Check if KEY_PATH environment variable is set
if [[ -z "${KEY_PATH}" ]]; then
  echo "KEY_PATH env var is expected"
  exit 5
fi

# Check if bastion IP address is provided
if [[ -z "${1}" ]]; then
  echo "Please provide bastion IP address"
  exit 5
fi

bastion_ip="${1}"
private_ip="${2}"
command="${3}"


#Case 1 - Connect to the private instance from your local machine
if [[ -n "${private_ip}" ]] && [[  ! "$3" ]]; then
  ssh -i "${KEY_PATH}" -o ProxyCommand="ssh -i ${KEY_PATH} -W %h:%p ubuntu@${bastion_ip}" ubuntu@${private_ip}
  exit $?
fi

# Case 2 - Connect to the public instance
if [[ -z "${private_ip}" ]] && [[ -z "${command}" ]]; then
  ssh -i "${KEY_PATH}" ubuntu@"${bastion_ip}"
  exit $?
fi

# Case 3 - Run a command in the private machine
if [[ -n "${private_ip}" && -n "${command}" ]]; then
  ssh -i "${KEY_PATH}" -o ProxyCommand="ssh -i ${KEY_PATH} -W %h:%p ubuntu@${bastion_ip}" ubuntu@${private_ip} "${command}"
  exit $?
fi


# Case 4 - Bad usage
echo "Please provide valid arguments"
exit 5

