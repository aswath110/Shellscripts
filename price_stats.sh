#!/bin/bash

#set -x
#yesdate=$(date --date="-1 day" +%Y-%m-%dT00:00:01)
#date=$(date +%H:)
now=$(date +%Y-%m-%dT%H:%M:%S)
clear


echo " ------------------------------------------UK-DATACENTER ($date)------------------------------------------------------- "


aws ec2 describe-spot-price-history --product-descriptions "Linux/UNIX (Amazon VPC)" --region eu-central-1 --availability-zone eu-central-1a --start-time $now --end-time $now | awk '{print $3" "$5}' > /users/aswath/scripts/price_stats_temp


for j in c3.2x  c5a.2x c5.2x c5ad.2x c5d.2x m3.2x m4.2x m5a.2x m5.2x m5ad.2x m5dn.2x m5d.2x r3.2x r4.2x r5a.2x r5.2x r5ad.2x r5dn.2x r5d.2x i3.2x i4i.2x c6id.2x c6gd.2x r6id.2x r6gd.2x m6id.2x m6gd.2x c3.x c4.x c5a.x c5.x c5ad.x c5d.x m3.x m4.x m5a.x m5.x m5ad.x m5dn.x m5d.x r3.x r4.x r5a.x r5.x r5ad.x r5dn.x r5d.x i3.x i4i.x c6gd.x r6gd.x m6gd.x ; do

	nodes=$(grep -i $j /users/aswath/scripts/price_stats_temp | sed "s/ \+/\t/g") 
        count=$(grep -i $j /files/allserverip-final |grep "172.31"|grep -i spot |awk '{print $3}' | wc -l)
	name=$(grep -i $j /files/allserverip-final |grep "172.31"|grep -i spot |awk '{print $1}' |  paste -s -d, - )
	echo "$nodes $count $name" | sed "s/ \+/\t/g"
done




echo "######################################################################################################################"


sleep 10

#set -x

echo " ------------------------------------------US-DATACENTER ($date)------------------------------------------------------- "


aws ec2 describe-spot-price-history --product-descriptions "Linux/UNIX (Amazon VPC)" --region us-east-1 --availability-zone us-east-1e --start-time $now --end-time $now | awk '{print $3" "$5}' > /users/aswath/scripts/price_stats_temp


for j in c3.2x c4.2x c5a.2x c5.2x c5ad.2x c5d.2x m3.2x m4.2x m5a.2x m5.2x m5ad.2x m5dn.2x m5d.2x r3.2x r4.2x r5a.2x r5.2x r5ad.2x r5dn.2x r5d.2x i3.2x i4i.2x c3.x c4.x c5a.x c5.x c5ad.x c5d.x m3.x m4.x m5a.x m5.x m5ad.x m5dn.x m5d.x r3.x r4.x r5a.x r5.x r5ad.x r5dn.x r5d.x i3.x i4i.x ; do

        nodes=$(grep -i $j /users/aswath/scripts/price_stats_temp | sed "s/ \+/\t/g")
        count=$(grep -i $j /files/allserverip-final |grep "172.30"|grep -i spot |awk '{print $3}' | wc -l)
        name=$(grep -i $j /files/allserverip-final |grep "172.30"|grep -i spot |awk '{print $1}' |  paste -s -d, - )
        echo "$nodes $count $name" | sed "s/ \+/\t/g"

done
echo "#################################################################################################################"
