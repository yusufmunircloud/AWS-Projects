#Python Lambda function that tags newly created EC2 instances with the name of the IAM user which created the instance, capturing the creator's name for improved ownership tracking.

import json
import boto3

ec2 = boto3.client('ec2')

def lambda_handler(event, context):
    print(event)
    
    # Get the IAM UserName
    user = event["detail"]["userIdentity"]["userName"]
    
    # Get the InstanceId
    InstanceId = event["detail"]["responseElements"]["instancesSet"]["items"][0]["instanceId"]
    
    ec2.create_tags(
        Resources=[
            InstanceId,
        ],
        Tags=[
            {
                'Key': 'Owner',
                'Value': user
            },
        ]
    )
    return
