# Simple Project: S3 Static Website Hosting

In this simple project you are going to implement a simple static website by utilizing S3 and its Static Hosting feature 

The simple project consists of 6 stages :-
```
• Step 1 : Create an S3 Bucket
• Step 2 : Turn on and configure the S3 Static Hosting Feature
• Step 3 : Allow Public Access by configuring the appropriate bucket policy
• Step 4 : Upload the websites code
• Step 5 : Test and go to your new website
• Step 6 : Cleanup the account
```

# STEP 1 - Create an S3 Bucket
Ensure you are logged into an AWS account, have admin privileges and are in the us-east-1 / N. Virginia Region

Move to the S3 console https://s3.console.aws.amazon.com/s3/buckets?region=us-east-1
Then on the left click ```Create Bucket```
For the Bucket Name field put: ```theme-switcher-s3hosting-uniquestring.``` Eg. theme-switcher-s3hosting-1234

In the AWS Region field select : ```US East (N. Virginia) us-east-1```

Under the ```Block Public Access settings for this bucket``` uncheck the the little box next to ```Block all public access```

Then scroll to the bottom of the page and click ```Create Bucket```

Note : For all setting and field not specified in these instruction, just leave them as default

# STEP 2 - Turn on and configure the S3 Static Hosting Feature

Once your S3 bucket is created, under buckets page, click your new bucket name and switch over to the properties tab 

Now in the properties tab, scroll all the way down to the bottom and on the ```Static Website Hosting``` click ``edit``

Now under the Static Website Hosting click ``Enable``





# STAGE 1 - FINISH   


