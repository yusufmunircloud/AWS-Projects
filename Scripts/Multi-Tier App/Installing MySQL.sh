# Run following commands after you SSH into your server

# install mysql-server package, you will need to enter a password, twice. Remember this password
sudo apt-get install mysql-server

# test mysql server installation
mysql -u root -p
<Enter password when prompted>

# exit mysql
mysql> exit

# edit localdb.php page with mysql server user and password, user should be root and password will be what you setup in the installation step above
sudo vi /var/www/html/localdb.php

// Setup local db connection details here
$con=mysqli_connect('localhost','DB_USERNAME','DB_PASSWORD');


