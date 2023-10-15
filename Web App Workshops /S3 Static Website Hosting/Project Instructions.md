# Simple Project: S3 Static Website Hosting

In this simple project you are going to implement a simple static website by utilizing S3 and its Static Hosting feature 

The simple project consists of 6 stages :-
```
• Step 1 : Create an S3 Bucket
• Step 2 : Turn on and configure the S3 Static Hosting Feature
• Step 3 : Allow Public Access by configuring the appropriate bucket policy
• Step 4 : Upload the websites code/files
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

Now in the properties tab, scroll all the way down to the bottom and on the ```Static Website Hosting``` click ```edit```

Now under ``Static Website Hosting`` click ``enable``

Under Hosting Type select ``Host a static website``

In the ``Index Document`` field, type: index.html
In the ``Error Document`` field, type: error.html

Now scroll to the bottom and click ``Save Changes``

# STEP 3 - Allow Public Access by configuring the appropriate bucket policy

Once finished saving changes for the ``Static Website Feature``, switch over to the ``Permissions`` tab and scroll down to the ``Bucket Policy`` section

Then click edit and copy and paste the following into the Bucket Policy Text Editor area under the ``Policy``: 

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadAccess",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::your-bucket-name/*"
            ]
        }
    ]
}
```
Find your bucket name and replace the : "arn:aws:s3:::``your-bucket-name``/*" with your s3 buckets name

Finally scroll down and click ``Save changes``

# STEP 4 - Upload the websites code/files
Once you've successfully put the bucket policy and saved changes, switch over to the objects tab 

Now in the objects tab, click ``upload``, and under ``Files and folders`` click add files and find the ``index.html`` file you downloaded earlier from the link at the top of this ``Project Instructions``page

At the bottom of the ``Upload`` page click ``Upload``


# STAGE 5 - Test and go to your new website

Once the index.html file is uploaded successfully, switch over to the properties tab and scroll all the way down

Once at the ``Static Website Hosting`` under the ``Bucket Website Endpoint`` click the website link 

Now try out the theme switcher, to go from light to dark mode

# STAGE 6 - Cleanup the account

Once done testing out your new website,go back to the S3 bucket console :https://s3.console.aws.amazon.com/s3/buckets?region=us-east-1&region=us-east-1

Now select your S3 bucket which you used to host the website for this project and to the left click ``empty``, then fill in the field ``permanently delete``

Once you've successfully emptied your bucket, select ``delete`` and type or copy and paste your S3 bucket name into the field to confirm your deletion


Now you have successfully returned your AWS account back into the state it was before this project


# Congratulations you have successfully hosted a full functioning static website on S3!!!!
















