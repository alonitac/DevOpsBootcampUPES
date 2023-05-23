set -e -x

source ../vpc.sh

PUBLIC_EC2=$(aws ec2 describe-instances --region $REGION --filters "Name=instance-id,Values=$PUBLIC_INSTANCE_ID")
PUBLIC_EC2_IP=$(echo $PUBLIC_EC2 | jq -r '.Reservations[0].Instances[0].PublicIpAddress')

PRIVATE_EC2=$(aws ec2 describe-instances --region $REGION --filters "Name=instance-id,Values=$PRIVATE_INSTANCE_ID")
PRIVATE_EC2_IP=$(echo $PRIVATE_EC2 | jq -r '.Reservations[0].Instances[0].PrivateIpAddress')
PRIVATE_EC2_AZ=$(echo $PRIVATE_EC2 | jq -r '.Reservations[0].Instances[0].Placement.AvailabilityZone')

echo "$COURSE_STAFF_SSH_KEY" > course_staff
chmod 400 course_staff

# push a 60sec lived ssh key to the private instance
aws ec2-instance-connect send-ssh-public-key --region $REGION --instance-id $PRIVATE_INSTANCE_ID --instance-os-user ubuntu2 --availability-zone $PRIVATE_EC2_AZ --ssh-public-key file://./course_staff.pub

set +e
export KEY_PATH=course_staff
bash ../bastion_connect.sh $PUBLIC_EC2_IP $PRIVATE_EC2_IP "curl --fail-with-body http://169.254.169.254/latest/meta-data/managed-ssh-keys/active-keys/ubuntu2"

if [ $? -ne "0" ]
then
  echo -e "\n\nbad bastion_connect.sh script"
  exit 1
else
  echo -e "\n\ngood bastion_connect.sh script! well done!"
fi