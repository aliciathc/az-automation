#! /bin/bash
user=`whoami`
datenow=`date +%m-%d-%y`
#datepass=$(date --date="-7 day" +%m-%d-%y)
wwnow=`date +%V`
wwpast=`echo $wwnow - $1|bc`

echo $wwpast


f1="/home/$user"
f2="$f1/az_automation"
f3="$f2/imgcleanup"
f4="$f3/subscriptionID"
f5="$f3/vmcleanuplist"


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

#Clean up folder for previos data
rm -rf $f3/*


#Output subsciption ID
azure account list|awk 'NR>3'|awk '{print $(NF-1)}'|head -n -1 >$f4


while read line
do

	echo "Reading $line"
	echo "Creating Snapshot Cleanup List for WorkWeek: $wwpast"
	azure vm image list -s $line | grep -w "User"|grep "SNapSHot_WW$wwpast-"|awk '{print $2}' > $f5-$line
	#azure vm image list -s $line | grep -w "User"|grep "SNapSHot-"|awk '{print $2}' > $f5-$line


        while read vmimage
	do

	echo "deleting $vmimage"
	azure vm image delete -s $line $vmimage
	
	done < $f5-$line

done <$f4





