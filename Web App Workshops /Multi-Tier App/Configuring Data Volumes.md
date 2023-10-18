# Configure Data Volume - EC2 Instance Setup

**Lecture:** In this video, let's take a look at how to configure the data volume. We'll create the volume, attach it to the server, install a file system, mount the volume to a specified point, and configure it to ensure it's mounted after reboots.

## Steps to Configure Data Volume

1. **Create Data Volume:**
   - Open the AWS Management Console.
   - Ensure the new volume is in the same availability zone as the ec2 instance.
   - Create the data volume (size: 1GB or as needed).

2. **Attach Data Volume:**
   - Select your EC2 instance.
   - From the "Actions" menu, choose "Attach Volume."
   - Attach the volume and note the device name (e.g., `/dev/sdf`).

3. **SSH into the Server:**
   - Use SSH to connect to your EC2 instance.

4. **Check Block Devices:**
   - Run `lsblk` to check the block devices attached to the EC2 instance.
   - The data volume may appear as `/dev/xvdf`.

5. **Install File System:**
   - Run the `makefs` command to install a file system on the data volume. `sudo mkfs -t ext4 /dev/xvdf`

6. **Create Mount Point:**
   - Create a mount point, e.g., `/data`, using `mkdir`. `sudo mkdir /data`

7. **Mount Data Volume:**
   - Mount the EBS volume to the created mount point.
   - This allows reading and writing to `/data`, which corresponds to the data volume. `sudo mount /dev/xvdf /data`

8. **Edit `fstab` Configuration:**
   - Edit the `/etc/fstab` configuration file to ensure the volume is automatically mounted after reboots. `sudo vi /etc/fstab`
   - Add a line to `/etc/fstab` to define the mount point.
   - /dev/xvdf   /data       ext4    defaults,nofail 0       2  #Copy this whole line and paste to bottom of fstab file, and save
9. **Test the Configuration:**
   - Run `sudo mount -a` to check for errors in the `fstab` configuration.
   - Use `df -h` to verify that the volume is mounted on `/data`.

10. **Reboot the Server:**
    - Reboot the EC2 instance to test if the volume is mounted automatically. `sudo reboot`

## Summary

In this video, we covered the steps to configure a data volume for an EC2 instance. The key tasks included creating, attaching, mounting, and configuring the volume for automatic mounting after reboots.

Good luck with this task, and feel free to proceed to the next set of videos in this module.
