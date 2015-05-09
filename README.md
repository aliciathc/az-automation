###Azure - Capture a Snapshot Image from Running VM###

1.      Cronjob:
            i.  Automation scripts will perform specialized snapshot on weekly basis on every Saturday
 
2.      Manually run in Linux terminal. The script will backup according to the defined subscription :
            i. To run single subscription:
			#az-snapshot_v1.0.sh [subscription id]
			./az-snapshot_v1.0.sh 95de8a8b-3d69-4a8d-8c5f-b77b47a0f8e4
 
           ii. To run all subscription:
		   
			#Type "all" after the script
			./az-snapshot_v1.0.sh all
 
3.      Snapshot Image Clean Up:
            i. The script will run weekly basis on every Sunday morning at 6.00 to clean up postdated snapshot images. Target postdated images would be 4 weeks old.
           ii. To change the target cleanup week, config the argument wen running the scripts:
 
            #./snapshot_cleanup_v1.0.sh [Target postdateddated week]
              ./snapshot_cleanup_v1.0.sh 4  (This will remove the images from 4 weeks back) 



###To Change Azure VM Status###

How it works?
 
This script able to perform for following command to change VM status:
1.        start
2.        shutdown
3.        restart
4.        delete
 
1. Cronjob:
            i. This script has been scheduled to run nightly by scanning through all subscriptions at 22.30.
           
2. Manually run in Linux terminal:
Ensure the following format has been entered:
 
            i.  To run on single subscription:
Example:
#To change all "StoppedVM" vm to "StoppedDeallocated" 
 
# az-status.sh [subscription ID] [vm - current status] [vm - to change status]
./az-status.sh 95de8a8b-3d69-4a8d-8c5f-b77b47a0f8e4 StoppedVM shutdown
 
          ii. To run all subscriptions:
Example:
               # az-status.sh all [vm - current status] [vm - to change status]
               ./az-status.sh all StoppedVM shutdown
 
3. Check the VM status from trminal or Azure management portal.
 
#VM status references
StoppedVM
StoppedDeallocated
ReadyRole
 
#Option in command for VM status
delete
start
restart
shutdown 




