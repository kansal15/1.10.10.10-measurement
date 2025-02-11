<h2>RIPE Atlas Ping/Dns Measurement Scripts</h2>

These Bash scripts are designed to measure the average ping/Dns times from various Indian probes to a set of specified IP addresses using the RIPE Atlas platform. The script collects ping/Dns measurement data, processes it and calculates the average ping/dns query time.

**Features:**

1. IP Addresses: The script allows you to specify a list of IP addresses to measure ping times.

2. Date Range: You can define a date range for the measurements, defaulting to the last 15 days.

3. Indian Probes: The script searches for Indian probes using the RIPE Atlas API and aggregates ping results from these probes.

4. Average Ping Calculation: It calculates the average ping time for each IP address from the collected data.

5. HTML Report: The script generates an HTML file (main.html) that visually represents the ping times using progress bars.


**Usage:**

  Prerequisites:

  1. Ensure you have the ripe-atlas command-line tool & bc installed and configured.

  Configuration:

1.  Modify the ip_addresses array to include the IP addresses you want to measure.

2.  Adjust the stopped_after_date and stopped_before_date variables if you need a different date range.

**Execution:**

  1. Run the script

**Output:**

  1. The script outputs the average Ping/Dns times.

  2. It also creates an HTML file (main.html) that visually displays the ping times using progress bars.

**Files Generated**

   1. list.of.indian.ipv4.probes: Contains the list of Indian probes.

   2. YYYY-MM-DD-YYYY-MM-DD.IP_ADDRESS.ping.measurements: Contains the measurement IDs for each IP address.

   3. ping.IP_ADDRESS.from.indian.probes: Contains the ping results from Indian probes for each IP address.
