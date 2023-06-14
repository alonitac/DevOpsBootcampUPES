#!/bin/bash

if [ -z "$KEY_PATH" ]; then
echo "Error, environamt variable not set"
exit 5
fi

echo "Enter the instance: in user@public-instance-ip "
read inst
ssh -i "$KEY_PATH" "$inst" << EOF

EOF

