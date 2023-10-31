import * as cdk from 'aws-cdk-lib';
import { Construct } from 'constructs';
import { Stack, StackProps } from 'aws-cdk-lib';
import { Code, Function, Runtime } from 'aws-cdk-lib/aws-lambda';
import { LambdaRestApi } from 'aws-cdk-lib/aws-apigateway';

// Define a class for the CDK stack
export class SimpleApi2LambdaStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    // Create a Lambda function named 'HelloHandler'
    const hello = new Function(this, "HelloHandler", {
      runtime: Runtime.NODEJS_14_X, // Specify the runtime for the Lambda function
      code: Code.fromAsset('lambda'), // Load the Lambda function code from the 'lambda' directory
      handler: 'hello.handler' // Specify the handler function in your Lambda code
    });

    // Create an API Gateway and connect it to the 'hello' Lambda function
    new LambdaRestApi(this, "ApiGateway", {
      handler: hello // Associate the API Gateway with the 'hello' Lambda function
    });
  }
}
