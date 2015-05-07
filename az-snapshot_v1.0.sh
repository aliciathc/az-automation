#! /bin/bash

#Find out username
user=`whoami`
datenow=`date +%m-%d-%y`
workweek=`date +%V`

######Define file path#######
f1="/home/$user"
f2="$f1/az_automation"
f3="$f2/snapshot"
f4="$f3/SubscriptionID.txt"
f5="$f3/VM_list"
f6="$f3/VM_Summary-$datenow"
#f6="$f2/vmcleanuplist"
#############################

######Define Argument#######
#Subscription
a1=$1
########################### 


function snapshot(){

        while read vmname
        do
		subscription_name2=`echo $subscription_name1|sed 's/ /_/g'`
                echo "Capturing backup snapshot for: $subscription_name2-SNapSHot_WW$workweek-$datenow-$vmname"
                
	        azure vm capture -o Specialized -s $line $vmname $subscription_name2-SNapSHot_WW$workweek-$datenow-$vmname

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
#azure account list|awk 'NR>3'|awk '{print $2,$3,$4}'|head -n -1 > $f6

#output VM list
echo "creating azure vm list..."


if  grep -w "$a1" $f4; 
then
	line=$a1	
	echo "Reading Subscription ID: $line"
	#echo "Subscription ID: $line" > $f4-$line
	azure vm list -s $line |grep -w "ReadyRole" > $f5-$line
		
	#Output current subscriptions VM
	#cat $f4-$line|awk 'NR >=5'|grep -w "$a2"|awk '{print$2}'>$f5
	#cat $f4-$line|awk 'NR >=5'|awk '{print$2}'|head -n -1> $f5
	cat $f5-$line|awk '{print$2}'> $f6

	subscription_name1=`azure account list|grep $a1 |awk '{print $2,$3,$4}'`
	echo $subscription_name1	
	
	snapshot

elif [ $a1="all" ]
then
	
	#if [ -f $f5 ]
	#then
        #	rm $f5 -f
	#fi

	i="3"

	while read line
        do
		
                echo "Reading Subscription ID: $line"
		#echo "Subscription ID: $line" >> $f4-$line
                azure vm list -s $line |grep -w "ReadyRole" >> $f5-$line

		#Output all subscriptions VM
		#cat $f4-$line|awk 'NR >=5'|grep -w "$a2"|awk '{print$2}'>$f5
		#cat $f4-$line|awk 'NR >=5'|awk '{print$2}'|head -n -1>$f5
		cat $f5-$line|awk '{print$2}'>$f6
		
		i=$[$i + 1]
		
		
		subscription_name1=`azure account list|awk "NR==$i"|awk '{print $2,$3,$4}'`
	 	echo $subscription_name1	
		snapshot
	done < $f4

	
else
	echo "Subscription ID $a1 was not found!"
	exit 1

fi
