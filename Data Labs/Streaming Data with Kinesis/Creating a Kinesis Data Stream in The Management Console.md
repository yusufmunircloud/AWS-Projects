# Creating a Kinesis Data Stream in AWS Management Console

Welcome to the Ultimate Guide to Stream Processing with Kinesis! In this simple demo, we'll walk you through creating a Kinesis Data Stream using the AWS Management Console.

## Prerequisites
- An AWS account with necessary permissions.

## Step 1: Accessing AWS Management Console
1. Log in to your AWS account.
2. Navigate to the **Services** page in the AWS Management Console, typically within your preferred region (e.g., North Virginia - US East 1).

## Step 2: Accessing Kinesis Services
3. In the search bar, type "kinesis" and click on the Kinesis search result that appears.

![](https://github.com/yusufmunircloud/AWS-Projects/blob/main/img/data%20lab-img/kinesis1.png?raw=true)

4. You'll find options to create a data stream.
![](https://github.com/yusufmunircloud/AWS-Projects/blob/main/img/data%20lab-img/kinesis2.png?raw=true)

## Step 3: Creating a Kinesis Data Stream
5. Click the **Create Data Stream** button.
6. Provide a name for your data stream (e.g., "MyKinesisStream").
7. Determine the number of shards you want your stream to have. You'll notice that the AWS console provides real-time feedback on the stream's write and read capacity based on the number of shards.
8. For example, a stream with four shards can handle up to four megabytes per second or 4000 data records per second for writing, and up to eight megabytes per second for reading. You can use the shard estimator to help choose the appropriate number of shards based on your specific application and workload.
9. Choose the desired number of shards (e.g., two) and click **Create Data Stream**.

## Step 4: Stream Provisioning
10. AWS will begin provisioning your stream, which may take a few moments.
11. Once the stream reaches an "Active" state, it can start ingesting data records from producers and serving data records to consumers.

## Additional Configuration (Optional)
12. The AWS Management Console offers various options for configuration.
   - **Applications**: Explore different ways to build producers and consumers for your Kinesis stream.
   - **Monitoring**: Monitor stream activity through CloudWatch metrics and other values.
   - **Configuration**: Adjust settings like data retention periods.

## Step 5: Deleting a Kinesis Data Stream
13. If you want to delete the data stream, it's as simple as clicking the "Delete" button.
14. Confirm the deletion, and it will take a few moments for AWS to remove the resources and stop billing you.

That's it! Creating a Kinesis Data Stream using the AWS Management Console is straightforward. In the next lecture, we'll show you how to create a Kinesis Data Stream using the AWS CLI.

Enjoy your journey through Kinesis, and stay tuned for more exciting topics! Thank you for watching.

