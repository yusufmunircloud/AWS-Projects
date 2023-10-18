# Create AMI and EBS Snapshot

**Instructor:** In this video, we will cover the last two items in our preparation checklist for recovery. These are creating an AMI (Amazon Machine Image) and an EBS (Elastic Block Store) snapshot. 

- The purpose of the AMI is to create a replacement server, which can be in the same or different availability zone depending on the failure scenario. The AMI should include our software, application, and configuration.

- The EBS snapshot is for data protection. It allows us to restore data if the data volume fails. The snapshot is of the data volume.

    - The AMI includes the root volume with software and configuration.
    - The snapshot covers only the data volume.

## Steps to Create AMI and Snapshot

1. **Create AMI:**
   - Select your EC2 instance.
   - From "Actions," choose "Image" and then "Create Image."
   - If your server has both root and data volumes, remove the data volume. The AMI should include only the root volume.
   - Provide a name for the AMI, e.g., "Fault Tolerance Single Instance."

2. **Create Snapshot:**
   - Go to your volumes.
   - Select the data volume.
   - Choose "Create Snapshot."
   - Give the snapshot a name.

Now you have an AMI with your server's software and an EBS snapshot to protect your data. In future videos, we'll use these for recovery in different failure scenarios.

Good luck with your preparation!

