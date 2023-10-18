### Setting Up Prerequisites for AWS Multi-Tier App

**Introduction:**
- Prerequisites for deploying a multi-tier AWS app include setting up an EC2 instance, connecting via SSH, and opening HTTP access.

**Key Concepts:**
- EC2 instance
- SSH access
- Security group
- Key pair

**Steps/Procedures:**
1. Select a region (e.g., US East 1) for lower service costs.
2. Use the default VPC (Virtual Private Cloud) in the chosen region.
3. The default VPC comes with a default security group.
4. Modify the security group to allow access on ports 22 (SSH) and 80 (HTTP).
5. Add rules for SSH and HTTP, specifying "anywhere" for source IP addresses.

**Code Snippets:**
- SSH rule example: Source IP: 0.0.0.0/0 (anywhere), Port: 22
- HTTP rule example: Source IP: 0.0.0.0/0 (anywhere), Port: 80

**Considerations:**
- Allowing "anywhere" for source IPs is not recommended for production; it's for demonstration purposes.
- Make sure your application needs to be publicly accessible if you allow access from anywhere.

**References:**
- [AWS EC2 Documentation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EC2_GetStarted.html)

### Launching an EC2 Instance

**Introduction:**
- Launching an EC2 instance is a crucial step for deploying applications on AWS.

**Key Concepts:**
- EC2 instance
- Amazon Machine Image (AMI)
- Key pair

**Steps/Procedures:**
1. In the EC2 dashboard, click "Launch Instance."
2. Choose an Ubuntu 16.04 AMI for this course.
3. Select "T2 Micro" as it's eligible for the AWS Free Tier.
4. Choose default settings for most options.
5. Ensure you create the instance in the default VPC.
6. Skip optional settings like EBS volumes and tags.
7. For security group, choose the default group with SSH and HTTP rules.

**Code Snippets:**
- Launching an instance, choosing Ubuntu 16.04 and T2 Micro.
- Selecting the default security group with SSH and HTTP rules.

**Considerations:**
- Using T2 Micro for cost-saving in the AWS Free Tier.
- Reusing the same key pair for multiple instances.

**References:**
- [AWS EC2 Documentation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EC2_GetStarted.html)

### SSH Connection to EC2 Instance

**Introduction:**
- SSH into your EC2 instance is essential to manage and deploy applications.

**Key Concepts:**
- SSH connection
- Private key
- Public IP
- Ubuntu user

**Steps/Procedures:**
1. Copy the private key file to your working directory. Eg. `cp Downloads/MyKeyPair Desktop`
2. Change permissions with `chmod 400` to make it readable only for the current user.
3. Securely store the private key and remove it from downloads. Eg. `rm Downloads/MyKeyPair.pem`
4. SSH into the instance using the `ssh -i` command. 
   For Linux: `ssh -i MyKeyPair.pem ec2-user@{publicip}`
   For Ubuntu: `ssh -i MyKeyPair.pem ubuntu@{publicip}`

5. Use the private key, Ubuntu user, and the public IP address to connect.
6. Verify your connection with Linux commands (e.g., `whoami`, `pwd`).
7. Exit the session when done. `exit`

**Code Snippets:**
- Copying the private key and changing permissions: `chmod 400 key.pem`
- SSH connection command: `ssh -i key.pem ubuntu@public_ip`

**Considerations:**
- Security is essential when handling private keys.
- Practice basic Linux commands for efficient use on the instance.

**References:**
- [SSH Documentation](https://www.ssh.com/ssh/)
