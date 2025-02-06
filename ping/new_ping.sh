#!/bin/bash

ip_address="1.10.10.10"
#ip_address="1.1.1.1"
#ip_address="8.8.8.8"
#ip_address="9.9.9.9"

stopped_after_date=$(date -d "15 days ago" +%Y-%m-%d)
stopped_before_date=$(date +%Y-%m-%d)
date=$(date +%Y-%m-%d)

# Get the list of Indian IPv4 probes
##ripe-atlas probe-search --country IN --status 1 --aggregate-by asn_v4 --limit 500 --max-per-aggregation 1 --ids-only > list.of.indian.ipv4.probes
ripe-atlas probe-search --country IN --status 1 --limit 500 --ids-only > list.of.indian.ipv4.probes

# Initialize the file to store all measurement IDs
> all.measurement.ids.$ip_address

# Loop through the date range in 2-day increments
current_date=$(date -d "$stopped_after_date" +%Y-%m-%d)
while [[ "$current_date" < "$stopped_before_date" ]]; do
    next_date=$(date -d "$current_date + 2 days" +%Y-%m-%d)
    
    # Search for measurements in the current 2-day window
    ripe-atlas measurement-search --type ping --af 4 --search $ip_address --started-after $current_date --started-before $next_date --ids-only --limit 1000 >> all.measurement.ids.$ip_address
    
    # Move to the next 2-day window
    current_date=$next_date
done

# Process the measurements
> ping.$ip_address.from.indian.probes
for i in $(cat all.measurement.ids.$ip_address); do
    echo $i
    ripe-atlas report $i --probes list.of.indian.ipv4.probes >> ping.$ip_address.from.indian.probes
done

# Calculate the average ping time
awk '/^rtt/ {print $4}' ping.$ip_address.from.indian.probes > time.test
awk -i inplace '{gsub("/", " "); print}' time.test
awk '{print $3}' time.test > time.new.$ip_address

> mean.values
sum=0
numbers=0
for j in $(awk '{print $1}' time.new.$ip_address); do
    k=${j//[!0-9.]/}
    echo $k >> mean.values
    sum=$(echo $sum $k | awk '{print $1+$2}')
    ((numbers+=1))
done

# Calculate the average ping time
if ((numbers == 0)); then
    avg=0
else
    avg=$(echo "$sum / $numbers" | bc -l)
fi

printf "Avg ping time for $ip_address is :%.2f\n" $avg
