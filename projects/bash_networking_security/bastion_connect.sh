#!/bin/bash

if [ -z "$KEY_PATH" ]; then
echo "Error, environamt variable not set"
exit 5
fi

echo "Enter the instance: in user@public-instance-ip "
read inst
ssh -i "$KEY_PATH" "$inst" << EOF

EOF

a=.ssh/authorized_keys


read -p "Enter the public instance " dns
ssh -i ubuntu@$dns
 
read -p "Enter the name of the key: " key_name 
ssh-keygen -f $key_name
chmod 400 $key_name

cat $key_name > $a
