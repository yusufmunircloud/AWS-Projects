# Configure Elastic IP Address

**Instructor:** In this video, we will configure an elastic IP address, which is a simple two-step process. We first allocate the elastic IP, which is essentially requesting AWS to assign an elastic IP address to our account. This elastic IP can be associated with any server in the region as it's at an account level, not tied to a specific server. After allocation, we proceed to associate the elastic IP with our server. This replacement causes the public IP address to be removed and replaced by the elastic IP address. 

## Steps to Configure Elastic IP

1. **Allocate Elastic IP:**
   - Navigate to the AWS Management Console.
   - Go to "Elastic IP Addresses" under "Network and Security."
   - Allocate an elastic IP address to your account.
   - The allocated IP will be in an orphaned state, not yet associated with any instance.

2. **Associate Elastic IP:**
   - Select the allocated elastic IP.
   - Choose "Actions" and then "Associate IP Address."
   - Select the EC2 instance you want to associate the elastic IP with.
   - Confirm the association.

3. **Verify IP Replacement:**
   - Return to your EC2 instance.
   - You'll notice that the Elastic IP field now has the assigned IP.
   - The public IP address will be replaced by the elastic IP address.

4. **Application Verification:**
   - Test your application using the new elastic IP address.
   - Update SSH connections to use the elastic IP address for access.

## Summary

In this video, we've allocated an elastic IP address at an account level and associated it with our EC2 instance. This replacement of the public IP address with the elastic IP address ensures that going forward, we must use the elastic IP for applications and SSH connections. 

Good luck with this task!
