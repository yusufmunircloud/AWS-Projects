## run these after you SSH into the server

# clone the app
git clone https://savitras@bitbucket.org/savitras/aws-course-php-app.git

# change to app folder
cd aws-course-php-app/

# install app dependencies
sh apt-get.sh

# install composer
curl -sS https://getcomposer.org/installer | php

# install AWS SDK
php composer.phar install

# deploy php pages to apache document root
sudo cp *.php /var/www/html/

# deploy vendor folder (contains AWS SDK) to the apache doc root
sudo cp -r vendor/ /var/www/html/

# deploy image to apache doc root
sudo cp aws-icon.png /var/www/html/

# IMPORTANT: change 'region' in dyn_session.php to the region you want to use, if different from us-east-1. This will help you later in the scalability module
sudo vi /var/www/html/dyn_session.php

// Setup region where your DynamoDB table is setup, e.g. us-east-1
$dynamoDb = DynamoDbClient::factory(array('region' => 'us-east-1',
