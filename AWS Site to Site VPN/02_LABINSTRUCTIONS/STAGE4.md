# Advanced Demo - Advanced Demo - Simple Site2Site VPN

#[Stage4] ![STAGEVPNALL](https://user-images.githubusercontent.com/128338058/235251857-773f54e9-507e-43a5-8fe6-20954f77c74d.PNG)


- Stage 1 - Create Site2Site VPN 
- Stage 2 - Configure onpremises Router 
- Stage 3 - Routing & Security 
- Stage 4 - Testing <= `YOU ARE HERE`
- Stage 5 - Cleanup


# TESTING 

From the EC2 console, select `onpremServer`, right click, click `connect`  
Choose `RDP Client`  
Choose `Connect using Fleet Manager`  
Click `Get password`  
Click `Browse`, locate the SSH key you selected when creating the infrastructure.  
Click `Open`  then `Decrypt Password`  
Copy the `Password` into your clipboard and note it down incase you need it again.  
Click `Fleet Manager Remote Desktop` this will open a new window  
Ensure `Authentication type` is set to `User Credentials`  
Enter `Administrator` in the `Username` box  
Paste in the password you just copied into your clipboard into the `Password` box.  
Click `Connect`  
This will connect you to the onpremServer (this might take a few minutes)  
Click the `instance ID` tab toward the top  (this will give you a larger view)  
Click `Yes` to any network prompts  
This `server` is located on the onPremises network  
open `internet explorer`  
get the `Private IPv4 address` of `awsServerA` from the EC2 console.  
into the web browser on `onpremServer` type http://private_ip_of_awsServerA
if you see an internet explorer security prompt ..click `Add`, type `http://private_ip_of_awsServerA` into the box, click `Add` then `Close`  
Click `Close`  
