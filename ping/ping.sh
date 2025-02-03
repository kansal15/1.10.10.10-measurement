#!/bin/bash

ip_address="1.10.10.10"
#ip_address="1.1.1.1"
#ip_address="8.8.8.8"
#ip_address="9.9.9.9"

stopped_after_date=$(date -d "15 days ago" +%Y-%m-%d)
stopped_before_date=$(date +%Y-%m-%d)
date=$(date +%Y-%m-%d)

ripe-atlas probe-search --country IN --status 1 --aggregate-by asn_v4 --limit 500 --max-per-aggregation 1 --ids-only > list.of.indian.ipv4.probes

ripe-atlas measurement-search --type ping --af 4 --search $ip_address --stopped-after $stopped_after_date --ids-only --limit 1000 > $stopped_after_date-$stopped_before_date.$ip_address.ping.measurements 

> ping.$ip_address.from.indian.probes
for i in $(cat $stopped_after_date-$stopped_before_date.$ip_address.ping.measurements); do
	echo $i
	ripe-atlas report $i --probes list.of.indian.ipv4.probes >> ping.$ip_address.from.indian.probes
done

awk '/^rtt/ {print $4}' ping.$ip_address.from.indian.probes > time.test
awk -i inplace '{gsub("/", " "); print}' time.test
awk '{print $3}' time.test > time.new

> mean.values
sum=0
numbers=0
for j in $(awk '{print $1}' time.new); do
	k=${j//[!0-9.]/}
	echo $k >> mean.values
	sum=$(echo $sum $k | awk '{print $1+$2}')
	((numbers+=1))
done
##((numbers==0)) && avg=$(echo "$sum / $numbers" | bc -l)
((numbers==0)) && avg=0 || avg=$(echo "$sum / $numbers" | bc -l)
printf "Avg ping time for $ip_address is :%.2f\n" $avg
