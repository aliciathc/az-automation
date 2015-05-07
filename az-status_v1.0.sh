#! /bin/bash

#Find out username
user=`whoami`
datenow=`date +%m-%d-%y`

######Define file path#######
f1="/home/$user"
f2="$f1/az_automation"
f3="$f2/vmstatus"
f4="$f3/SubscriptionID.txt"
f5="$f3/VM_fulllist"
f6="$f3/VM_filterlist"
f7="$f3/VM_Summary-$datenow"
#############################

######Define Argument#######
#Subscription
a1=$1
#TO Grep VM current status
a2=$2
#TO Change VM status
a3=$3
########################### 

function setvmstatus(){

	#Output stopped VM
	#cat $f4-$line|awk 'NR >=5'|grep $a2|awk '{print$2}'>$f5
        
	#change VM state via cli
	while read vmname
	do
		echo "Changing Instance Status: $vmname"
        	echo "Instance: $vmname Subscription ID: $line" >>$f7-$a2
        	azure vm $a3 -s $line $vmname
              
	done < $f6

	echo "#####DONE#####"
        
}

#Make directory to run scripts
if [ ! -d $f2 ]
then
        echo "Creating directory for $f2..."
	mkdir $f2
fi

if [ ! -d $f3 ]
then
        echo "Creating directory for $f3..."
	mkdir $f3
fi
#Clean up all files in /home/az_automation
rm -rf $f3/*


#Output subsciption ID
azure account list|awk 'NR>3'|awk '{print $(NF-1)}'|head -n -1 > $f4

#output VM list
echo "creating azure vm list..."


if  grep -w "$a1" $f4; 
then
	line=$a1	
	echo "Reading Subscription ID: $line"
	echo "Subscription ID: $line" > $f5-$line
	azure vm list -s $line > $f5-$line
		
	#Output stopped VM
	cat $f5-$line|awk 'NR >=5'|grep -w "$a2"|awk '{print$2}'>$f6

	setvmstatus

elif [ $a1="all" ]
then
	
	if [ -f $f5 ]
	then
        	rm $f5 -f
	fi


	while read line
        do
                echo "Reading Subscription ID: $line"
		echo "Subscription ID: $line" >> $f5-$line
                azure vm list -s $line >> $f5-$line

		#Output stopped VM
		cat $f5-$line|awk 'NR >=5'|grep -w "$a2"|awk '{print$2}'>$f6
	
		setvmstatus
	done < $f4
	
	#setvmstatus

else
	echo "Subscription ID $a1 was not found!"
	exit 1

fi
