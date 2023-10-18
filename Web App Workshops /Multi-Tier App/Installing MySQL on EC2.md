# Setting Up MySQL Server on EC2

In this video, we will guide you through the process of setting up a MySQL server on an Amazon EC2 instance, allowing for connectivity testing with a PHP application.

## Prerequisites:
- AWS Account
- EC2 Instance
- SSH Access to EC2
- PHP Application

## Steps:

### 1. Launch EC2 Instance
- Launch an EC2 instance using your AWS account.
- Ensure that the instance has a security group that allows MySQL traffic (port 3306) inbound.

### 2. SSH into the EC2 Instance
- Use SSH to connect to your EC2 instance.
- You should have administrative access to the server.

### 3. Install MySQL Server
- Use the `apt-get` package manager to install MySQL Server on the EC2 instance. `sudo apt-get install mysql-server`
- During installation, you'll be prompted to set the root user password. Confirm it.

### 4. Test MySQL Installation
- After MySQL is installed, it's a good practice to test it immediately.
- Use the following command to connect to MySQL:
    ```shell
    mysql -u root -p
    ```
    Provide the root password you set during installation. If you were never prompted to enter a root password when installing MySQL that means there is no password, so         just simply click enter

### 5. Create a MySQL Database (Optional)
- While in the MySQL shell, you can create a database:
    ```sql
    CREATE DATABASE mydb;
    ```
    Replace `mydb` with the desired database name.

### 6. Configure PHP Application
- Edit the `localdb.php` file within your PHP application. `sudo vi /var/www/html/localdb.php`
- Add the MySQL connection details, including the username and password.
- The username is usually "root," and the password is what you set during installation.

### 7. Test Connectivity
- Access the PHP application and test the connection to the MySQL server.
- If it's successful, you should see "connected successfully."
- If not, troubleshoot by checking your MySQL credentials and ensuring that the MySQL server is running.

## Conclusion
You have successfully set up a MySQL server on your EC2 instance, configured the connection details in your PHP application, and tested the connectivity. Good luck with your MySQL server setup!
