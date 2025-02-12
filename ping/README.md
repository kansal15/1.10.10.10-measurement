**Ping measurement script**

This Bash script (ping_measurement_India.sh) is designed to calculate the average ping time from Indian IPv4 probes to a list of specified IP addresses over a 15-day period. The script uses the RIPE Atlas API to search for ping measurements and processes the results to compute the average ping time for each IP address.

Key Features:

    IP Address Processing: The script processes a predefined list of IP addresses.

    Date Range Handling: It iterates through a 15-day period in 2-day increments to gather ping measurements.

    RIPE Atlas Integration: Utilizes the RIPE Atlas API to search for ping measurements and retrieve results from Indian IPv4 probes.

    Average Ping Calculation: Computes the average ping time for each IP address and saves the results to an output file.

Output:

    The script generates an output.txt file containing the average ping times for each IP address, along with the date of execution.

Dependencies:

    RIPE Atlas CLI: The script requires the RIPE Atlas command-line tool (ripe-atlas) & bc to interact with the RIPE Atlas API.

    Bash Environment: The script is written in Bash and should be executed in a compatible shell environment.

Usage:

    Ensure the RIPE Atlas CLI is installed and configured.

    Update the ip_addresses array with the desired IP addresses.

    Run the script in a Bash environment.
