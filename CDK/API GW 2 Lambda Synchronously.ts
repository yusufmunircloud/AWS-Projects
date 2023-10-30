
import * as cdk from 'aws-cdk-lib';
import { SqsQueue } from 'aws-cdk-lib/aws-events-targets';
import { Queue } from 'aws-cdk-lib/aws-sqs';
import { Construct } from 'constructs';
import { Duration, RemovalPolicy, Stack, StackProps } from 'aws-cdk-lib/core'; // Import Duration from core
import { Bucket } from 'aws-cdk-lib/aws-s3';

export class HelloCdkStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    const queue = new Queue(this, 'HelloCDKQueue', {
      visibilityTimeout: Duration.seconds(300)
    });
    
    const newBucket = new Bucket(this, 'HelloCDK-Bucket', {
      versioned: true,
      removalPolicy: RemovalPolicy.DESTROY,
      autoDeleteObjects: true

    });
  
  
  }
}
