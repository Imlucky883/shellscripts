#/bin/bash

# ****************************************************************

# Name : select_resource_list.sh
# Author : Laxman Patel
# Version : 0.0.1
# Description : This script takes input from the user and outputs the resource list

# ****************************************************************

# To check the number of arguments

if [ $# -ne 1 ]; then
    echo "Usage: filename [region]"
    exit 1
fi

# Check if AWS CLI is installed


if [! command -v aws &> /dev/null]; then
    echo "AWS CLI is not installed"
    exit 1
fi

# Configure AWS CLI

if [ ! -f ~/.aws/config ]; then
    echo "AWS CLI configuration not found. Please configure AWS CLI before running this script."
    exit 1
fi

# Get an array of numbers from the user

echo " Enter the numbers separated by spaces of the services you want the output for : "
echo " 1.  ec2" 
echo " 2.  s3"
echo " 3.  lambda"
echo " 4.  dynamodb"
echo " 5.  rds"
echo " 6.  vpc"
echo " 7.  cloudfront"
echo " 8.  route53"
echo " 9.  iam"
echo " 10. sns"

read -a services

echo " The list of services are : ${services[@]} "


# Validate the input

for service in "${services[@]}"; do
    echo "********************************************************************************** "
    case "$service" in
    1)
        echo "listing EC2 instances in the region : $1"
        aws ec2 describe-instances --region $1 | jq -r ".Reservations[].Instances[].PrivateDnsName"
        ;;
    5)
        echo "listing RDS instances in the region : $1"
        aws rds describe-db-instances --region $1 | jq -r '.DBInstances'
        ;;
    2)
        echo "listing S3 buckets in the region : $1"
        aws s3api list-buckets --region $1 | jq -r '.Buckets[].Name'
        ;;
    7)
        echo "Listing CloudFront Distributions in $1"
        aws cloudfront list-distributions --region $1
        ;;
    6)
        echo "Listing VPCs in $1"
        aws ec2 describe-vpcs --region $1
        ;;
    9)
        echo "Listing IAM Users in $1"
        aws iam list-users --region $1
        ;;
    8)
        echo "Listing Route53 Hosted Zones in $1"
        aws route53 list-hosted-zones --region $1
        ;;
    3)
        echo "Listing Lambda Functions in $1"
        aws lambda list-functions --region $1
        ;;
    4)
        echo "Listing DynamoDB Tables in $1"
        aws dynamodb list-tables --region $1
        ;;
    *)
        echo "Invalid service. Please enter a valid service."
        exit 1
        ;;
    esac
done
