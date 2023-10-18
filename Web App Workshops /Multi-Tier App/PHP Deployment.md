### Deploying a PHP Application on EC2 Instance

**Introduction:**
- Deploying a PHP application on an EC2 instance involves several steps, including cloning the application, installing dependencies, and verifying its functionality.

**Key Concepts:**
- Git clone
- Dependency installation
- Apache document root: `/var/www/html`
- AWS SDK
- Composer

**Steps/Procedures:**
1. Clone the PHP application from a public Git repository using the `git clone` command.
   - This creates a folder with the application code.
2. Install dependencies (PHP, Apache Web Server, MySQL client) using `apt-get` - Ubuntu's package manager.
   - A shell script is provided to automate this process.
   - Run the script using `sh apt-get.sh`.
3. Install the AWS SDK, a library for interfacing with AWS services (e.g., DynamoDB, CloudFront), using Composer - a PHP package manager.
   - First, install Composer with `curl` within the application folder.
   - Use Composer to install the AWS SDK.
4. Deploy the PHP application by moving the PHP pages to the Apache document root.
   - Use `sudo cp` to copy PHP pages to `/var/www/html`.
   - Copy the vendor folder and any necessary images.
   
**Code Snippets:**
- Cloning the application: `git clone [repository URL]`
- Running the apt-get shell script: `sh apt-get.sh`
- Installing Composer: `curl -sS https://getcomposer.org/installer | php`
- Installing the AWS SDK with Composer: `php composer.phar install`

**Considerations:**
- Ensure you run the commands within the application folder.
- Be cautious with permissions, especially when using `sudo`.

**Verification:**
1. Access the public IP address in a web browser.
2. Visit `index.php` to verify it displays "hello world."
3. Check `session.php` to ensure session management works.
4. Examine `image.php` to view a locally stored image.
5. Verify `localdb.php`, which may show a "failed to connect" message until MySQL is set up.

**Creating an AMI:**
- After successful deployment, create an Amazon Machine Image (AMI) from the EC2 instance.
- Use this AMI to launch new instances with the PHP application pre-configured.

**References:**
- [Git Documentation](https://git-scm.com/)
- [Composer Documentation](https://getcomposer.org/)
- [AWS SDK for PHP](https://docs.aws.amazon.com/aws-sdk-php/v3/guide/getting-started/installation.html)

### Conclusion

- The deployment process for a PHP application on an EC2 instance involves cloning, dependency installation, and verification.
- Ensure that the AMI is created after successful deployment for future use.

**Next Steps:**
- In the next video, we will delve into further AWS services and functionalities.
- Good luck with your work, and see you in the next video!
