<h2>RIPE Atlas DNS Measurement Script</h2>

This Bash script (dns_measurement_India.sh) is designed to calculate the average DNS query time from Indian IPv4 probes to a list of specified IP addresses over a 15-day period. The script uses the RIPE Atlas API and RIPE Atlas probes to search for DNS measurements and processes the results to compute the average DNS time for each IP address.

Key Features:

    IP Address Processing: The script processes a predefined list of IP addresses.

    Date Range Handling: It iterates through a 15-day period in 2-day increments to gather DNS measurements.

    RIPE Atlas Integration: Utilizes the RIPE Atlas API to search for DNS measurements and retrieve results from Indian IPv4 probes.

    Average DNS query time Calculation: Computes the average DNS time for each IP address and saves the results to an output file.

Output:

    The script generates an output.txt file containing the average DNS query times for each IP address, along with the date of execution.

Dependencies:

    RIPE Atlas CLI: The script requires the RIPE Atlas command-line tool (ripe-atlas) & bc to interact with the RIPE Atlas API.

    Bash Environment: The script is written in Bash and should be executed in a compatible shell environment.

Usage:

[RIPE Atlas command-line tool](https://ripe-atlas-tools.readthedocs.io/en/latest/installation.html)

    Ensure the RIPE Atlas CLI is installed and configured.

    Update the ip_addresses array with the desired IP addresses.

    Run the script in a Bash environment.
