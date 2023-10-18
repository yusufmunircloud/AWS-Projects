# SSH into your EC2 instance and run following commands:

#Stop mysql:
sudo systemctl stop mysql

# Copy mysql db to /data, mount point of data vol, note that file permissions are also copied:
sudo rsync -av /var/lib/mysql /data

# Edit mysql config to change datadir, edit /etc/mysql/mysql.conf.d/mysqld.cnf:
sudo vi /etc/mysql/mysql.conf.d/mysqld.cnf

datadir=/data/mysql # change datadir to this

# Edit AppArmor access rules, add this line below to /etc/apparmor.d/tunables/alias:
sudo vi /etc/apparmor.d/tunables/alias

alias /var/lib/mysql/ -> /data/mysql/,

# Restart Apparmor:
sudo systemctl restart apparmor

# Restart Mysql:
sudo mkdir /var/lib/mysql/mysql -p # this is to pass env checks
sudo systemctl start mysql
