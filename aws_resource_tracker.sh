#!/bin/bash
#
############################################
#
# Author: Deekshith
# date: 12-08-2024
#
# Version: v1
#
# this script will report the AWS resource usage
############################################
set -x 
#  AWS S3
#  AWS EC2
#  AWS LAMBDA
#  AWS IAM Users

# List S3 buckets
aws s3 ls

# List EC2 instances
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId'

# List Lambda 
aws lambda list-functions

# List IAM User
aws iam list-users | jq '.Users[].UserName'
