source ../vpc.sh

VPC=$(aws ec2 describe-vpcs --region $REGION --filter "Name=vpc-id,Values=$VPC_ID")

echo -e "VPC founded: \n $VPC \n\n"

VPC_NAME=$(echo $VPC | jq -r '.Vpcs[0].Tags[] | select(.Key=="Name").Value')

if [ -z "$VPC_NAME" ]
then
  echo -e "\n\nVPC with ID $VPC_ID not found"
  exit 1
fi

PUBLIC_SUBNET=$(aws ec2 describe-subnets --region $REGION --filters "Name=vpc-id,Values=$VPC_ID" "Name=cidr-block,Values=10.0.0.0/24")

echo -e "public subnet founded: \n $PUBLIC_SUBNET \n\n"

PUBLIC_SUBNET_ID=$(echo $PUBLIC_SUBNET | jq -r '.Subnets[0].SubnetId')

if [ -z "$PUBLIC_SUBNET_ID" ]
then
  echo -e "\n\npublic subnet was not found"
  exit 1
fi

PRIVATE_SUBNET=$(aws ec2 describe-subnets --region $REGION --filters "Name=vpc-id,Values=$VPC_ID" "Name=cidr-block,Values=10.0.1.0/24")

echo -e "private subnet founded: \n $PRIVATE_SUBNET \n\n"

PRIVATE_SUBNET_ID=$(echo $PRIVATE_SUBNET | jq -r '.Subnets[0].SubnetId')

if [ -z "$PRIVATE_SUBNET_ID" ]
then
  echo -e "\n\nprivate subnet was not found"
  exit 1
fi

IGW=$(aws ec2 describe-internet-gateways --region $REGION --filters="Name=attachment.vpc-id,Values=$VPC_ID")

echo -e "internet gateway founded: \n $IGW \n\n"

IGW_ID=$(echo $IGW | jq -r '.InternetGateways[0].InternetGatewayId')

if [ -z "$IGW_ID" ]
then
  echo -e "\n\ninternet gateway was not found"
  exit 1
fi

ROUTE_TABLE=$(aws ec2 describe-route-tables --region $REGION --filters="Name=association.subnet-id,Values=$PUBLIC_SUBNET_ID")

echo -e "public route table founded: \n $ROUTE_TABLE \n\n"

ROUTE_TABLE_ID=$(echo $ROUTE_TABLE | jq -r '.RouteTables[0].RouteTableId')

if [ -z "$ROUTE_TABLE_ID" ]
then
  echo -e "\n\nroute table associated with the public subnet was not found"
  exit 1
fi


if [ "$(echo $PUBLIC_SUBNET | jq -e -r '.Subnets[0].MapPublicIpOnLaunch')" != "true" ]
then
  echo -e "\n\nthe public subnet MapPublicIpOnLaunch attribute should be true"
  exit 1
fi

if [ "$(echo $PRIVATE_SUBNET | jq -e -r '.Subnets[0].MapPublicIpOnLaunch')" != "false" ]
then
  echo -e "\n\nthe private subnet MapPublicIpOnLaunch attribute should be false"
  exit 1
fi

if ! echo $ROUTE_TABLE | grep -q "$IGW_ID"
then
  echo -e "\n\nthe route table associated with the public subnet should hold a route with the internet gateway as target"
  exit 1
fi
