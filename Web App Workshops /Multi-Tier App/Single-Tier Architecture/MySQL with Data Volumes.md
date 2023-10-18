# Configure MySQL to Use Data Volume

**Instructor:** In this video, we'll configure MySQL to use a data volume. This involves changing the data directory configuration from its default location to a new one on the data volume. This ensures MySQL reads and writes data from the new volume, improving recovery from failures.

## Steps to Configure MySQL

1. **Stop MySQL Server:**
   - SSH into the server and use the following command to stop the MySQL server:
     ```shell
     sudo service mysql stop
     ```

2. **Rsync MySQL Data:**
   - Synchronize MySQL data from its current location (`/var/lib/MySQL`) to the data volume mount point (`/data`). This copies files with appropriate permissions:
     ```shell
     sudo rsync -av /var/lib/MySQL /data
     ```

3. **Edit MySQL Configuration:**
   - Open the MySQL configuration file for editing:
     ```shell
     sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf
     ```
   - Change the data directory configuration line to point to `/data`:
     ```shell
     # Comment out the old line:
     # datadir = /var/lib/mysql
     datadir = /data/mysql
     ```
   - Save and exit the file.

4. **Edit AppArmor (Optional):**
   - In Ubuntu, you may need to edit AppArmor for security settings. Add the following line to the `alias` section:
     ```shell
     /data/mysql/ r,
     ```

5. **Restart AppArmor:**
   - Apply the AppArmor changes with:
     ```shell
     sudo service apparmor restart
     ```

6. **Prepare for MySQL Restart:**
   - Use the following command to help with the MySQL restart:
     ```shell
     sudo mysqlcheck -u root -p --auto-repair --check --optimize --all-databases
     ```

7. **Restart MySQL Server:**
   - Restart the MySQL server to apply the new configuration:
     ```shell
     sudo service mysql restart
     ```

8. **Verify Connectivity:**
   - Check that the MySQL server connects successfully. You can use a local `db.php` page for this verification.

## Summary

In this video, we changed the MySQL data directory to point to a new location on a separate data volume. This ensures MySQL data is stored on the data volume, improving recovery options. We stopped MySQL, synchronized data, edited the MySQL configuration, and made security adjustments (if necessary). After restarting MySQL, we verified the connectivity to the MySQL server.

Good luck with this task!
