set -e

# remove private ssh key from previous steps
rm -f course_staff

source ../vpc.sh

PUBLIC_EC2=$(aws ec2 describe-instances --region $REGION --filters "Name=instance-id,Values=$PUBLIC_INSTANCE_ID")
PUBLIC_EC2_IP=$(echo $PUBLIC_EC2 | jq -r '.Reservations[0].Instances[0].PublicIpAddress')

PRIVATE_EC2=$(aws ec2 describe-instances --region $REGION --filters "Name=instance-id,Values=$PRIVATE_INSTANCE_ID")
PRIVATE_EC2_IP=$(echo $PRIVATE_EC2 | jq -r '.Reservations[0].Instances[0].PrivateIpAddress')

echo "$COURSE_STAFF_SSH_KEY" > course_staff
chmod 400 course_staff

export KEY_PATH=course_staff
OLD_KEYS=$(bash ../bastion_connect.sh $PUBLIC_EC2_IP $PRIVATE_EC2_IP "cat ~/.ssh/authorized_keys")

ssh -i $KEY_PATH ubuntu@$PUBLIC_EC2_IP "./ssh_keys_rotation.sh $PRIVATE_EC2_IP"

NEW_KEYS=$(bash ../bastion_connect.sh $PUBLIC_EC2_IP $PRIVATE_EC2_IP "cat ~/.ssh/authorized_keys")
NEW_PUBLIC_KEY_FILE=$(ssh -i $KEY_PATH ubuntu@$PUBLIC_EC2_IP "cat new_key.pub")

if [ "$(echo "$NEW_KEYS" | wc -l)" -gt "$(echo "$OLD_KEYS" | wc -l)" ]
then
  echo "\n\nnumber of key in ~/.ssh/authorized_keys before and after the rotation should remain the same"
  exit 1
fi

if ! echo "$NEW_KEYS" | grep -q "$NEW_PUBLIC_KEY_FILE"
then
    echo -e "\n\nthe public key 'new_key.pub' in the public instance must be the same as in ~/.ssh/authorized_keys in the private instance.\n\n\nnew_key.pub is: \n\n $NEW_PUBLIC_KEY_FILE \n\n while the key found in ~/.ssh/authorized_keys is \n\n $NEW_KEYS"
    exit 1
fi

echo "Good rotation!"

