#/bin/bash

# *********************************************************************************

# Name: AWS_RESOURCE_LIST.sh

# Author: Laxman Patel

# Email: laxman.patel@gmail.com

# Version: 0.0.1

# Description: This script will fetch and display the details of AWS resources such as EC2 instances, RDS,S3, etc

# Requirements: AWS CLI installed and configured

# Usage:./AWS_RESOURCE_LIST.sh <region> <resource> 
# Examples: ./AWS_RESOURCE_LIST.sh ap-southeast-1 ec2

# *********************************************************************************

# To check the number of arguments

if [ $# -ne 2 ]; then
    echo "Usage: filename [region][type]"
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


# Fetch and display details of AWS resources

case "$2" in
    ec2)
        echo "listing EC2 instances in the region : $1"
        aws ec2 describe-instances --region $1 | jq -r '.Reservations[].Instances' 
        ;;
    rds)
        echo "listing RDS instances in the region : $1"
        aws rds describe-db-instances --region $1 | jq -r '.DBInstances'
        ;;
    s3)
        echo "listing S3 buckets in the region : $1"
        aws s3api list-buckets --region $1 | jq -r '.Buckets[].Name'
        ;;
    cloudfront)
        echo "Listing CloudFront Distributions in $1"
        aws cloudfront list-distributions --region $1
        ;;
    vpc)
        echo "Listing VPCs in $1"
        aws ec2 describe-vpcs --region $1
        ;;
    iam)
        echo "Listing IAM Users in $1"
        aws iam list-users --region $1
        ;;
    route5)
        echo "Listing Route53 Hosted Zones in $1"
        aws route53 list-hosted-zones --region $1
        ;;
    cloudwatch)
        echo "Listing CloudWatch Alarms in $1"
        aws cloudwatch describe-alarms --region $1
        ;;
    cloudformation)
        echo "Listing CloudFormation Stacks in $1"
        aws cloudformation describe-stacks --region $1
        ;;
    lambda)
        echo "Listing Lambda Functions in $1"
        aws lambda list-functions --region $1
        ;;
    sns)
        echo "Listing SNS Topics in $1"
        aws sns list-topics --region $1
        ;;
    sqs)
        echo "Listing SQS Queues in $1"
        aws sqs list-queues --region $1
        ;;
    dynamodb)
        echo "Listing DynamoDB Tables in $1"
        aws dynamodb list-tables --region $1
        ;;
    ebs)
        echo "Listing EBS Volumes in $1"
        aws ec2 describe-volumes --region $1
        ;;
    *)
        echo "Invalid service. Please enter a valid service."
        exit 1
        ;;
esac
