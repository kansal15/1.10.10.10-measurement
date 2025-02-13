#!/bin/bash

dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$dir"

# List of IP addresses
ip_addresses=("1.10.10.10" "8.8.8.8" "1.1.1.1" "9.9.9.9")

# Date range setup
stopped_after_date=$(date -d "15 days ago" +%Y-%m-%d)
stopped_before_date=$(date +%Y-%m-%d)
date=$(date +%Y-%m-%d)

# Output file
output_file="output.txt"

echo " " >> "$output_file"
echo "Date: $(date +%d-%m-%Y)" >> "$output_file"

# Loop through each IP address
for ip_address in "${ip_addresses[@]}"; do
    echo "Processing IP: $ip_address"
    
    # Get the list of Indian IPv4 probes
    /root/.local/bin/ripe-atlas probe-search --status 1 --country IN --limit 500 --max-per-aggregation 1 --ids-only > list.of.indian.ipv4.probes

    # Initialize an empty file to store all measurement IDs
    > all_measurement_ids.$date.$ip_address

    # Loop through the date range in 2-day increments
    current_date=$(date -d "$stopped_after_date" +%Y-%m-%d)
    while [[ "$current_date" < "$stopped_before_date" ]]; do
        next_date=$(date -d "$current_date + 2 days" +%Y-%m-%d)
        
        # Ensure the next_date does not exceed the stopped_before_date
        if [[ "$next_date" > "$stopped_before_date" ]]; then
            next_date="$stopped_before_date"
        fi
        
        echo "Searching measurements between $current_date and $next_date"
        
        # Search for measurements in the current 2-day window
        /root/.local/bin/ripe-atlas measurement-search --type dns --af 4 --search $ip_address --ids-only --limit 1000 --started-after $current_date --started-before $next_date >> all_measurement_ids.$date.$ip_address
        
        # Move to the next 2-day window
        current_date="$next_date"
    done

    # Process the measurements using the list of Indian probes
    > dns.$ip_address.from.indian.probes.$date
    for i in $(cat all_measurement_ids.$date.$ip_address); do
        echo $i
        /root/.local/bin/ripe-atlas report $i --probes list.of.indian.ipv4.probes >> dns.$ip_address.from.indian.probes.$date
    done

    # Extract and calculate the average DNS query time
    grep "Query time" dns.$ip_address.from.indian.probes.$date > query_time_$ip_address.$date

    > mean.values
    sum=0
    numbers=0
    for j in $(awk '{print $4}' query_time_$ip_address.$date); do
        k=${j//[!0-9.]/}
        echo $k >> mean.values
        sum=$(echo $sum $k | awk '{print $1+$2}')
        ((numbers+=1))
    done

    # Calculate the average DNS query time
    if ((numbers == 0)); then
        avg=0
    else
        avg=$(echo "$sum / $numbers" | bc -l)
    fi

    # Append the date and DNS query time to output.txt
    printf "Avg DNS query time for $ip_address is :%.2f\n" $avg
    printf "Avg DNS query time for $ip_address is: %.2f\n" $avg >> "$output_file"
done

