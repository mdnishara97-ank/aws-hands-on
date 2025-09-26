#!/bin/bash


###################
# Auther: Naduni
# Date: 25th-Sep
#
# Version: v1
#
# This script will report the AWS resource report
######################################


# AWS S3
# AWS EC2
# AWS Lambda
# AWS IAM Users

#debug Mode
set -x
#create filename with the today date

DATE=$(date +%F)
REPORT="/home/ubuntu/aws-report-$DATE.txt"

#add heading to the report

echo "AWS Resource Report - $DATE" > $REPORT
echo "=======================" >> $REPORT

# list s3 buckets

echo -e  "\nS3 Buckets: " >> $REPORT
aws s3 ls >> $REPORT

# list ec2 instances

echo -e "\nEC2 Instances:" >> $REPORT
aws ec2 describe-instances \
--query "Reservations[].Instances[].{ID:InstanceId,Type:InstanceType,State:State.Name,PublicIP:PublicIpAddress}" \
--output table >> $REPORT


# list lambda
echo -e "\nLambda Functions:" >> $REPORT

aws lambda list-functions \
--query "Functions[].{Name:FunctionName,Runtime:Runtime} " \
--output table >> $REPORT

# list IAM users
echo -e "\nIAM Users:" >> $REPORT

aws iam list-users \
--query "Users[].{User:UserName,Created:CreateData}" \
--output table >> $REPORT

echo "Report Saved: $REPORT"

