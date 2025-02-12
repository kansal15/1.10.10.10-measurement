<h2>DNS Servers: A Brief Overview</h2>

DNS (Domain Name System) servers are essential components of the internet that translate human-readable domain names (e.g., www.nic.in) into machine-readable IP addresses (e.g., 192.0.2.1). This process allows users to access websites and services using easy-to-remember names instead of complex numerical addresses.

How DNS Servers Work

    Query Initiation: When you type a domain name into your browser, your device sends a query to a DNS server.

    Recursive Resolution: The DNS server searches for the corresponding IP address by querying other DNS servers in a hierarchical manner (root servers, TLD servers, authoritative servers).

    Response: Once the IP address is found, it is returned to your device, allowing the browser to connect to the desired website or service.

Types of DNS Servers

    Recursive Resolver: Handles DNS queries from clients and communicates with other DNS servers to find the correct IP address.

    Root Server: The top-level DNS server that directs queries to the appropriate Top-Level Domain (TLD) server.

    TLD Server: Manages domain extensions (e.g., .com, .org) and directs queries to authoritative servers.

    Authoritative Server: Holds the actual DNS records for a specific domain and provides the final IP address.

Why DNS Servers Matter

    User Convenience: Makes it easier to navigate the internet using domain names instead of IP addresses.

    Load Distribution: Enables load balancing by directing traffic to different servers.

    Redundancy and Reliability: Ensures internet services remain accessible even if some servers fail.


Use case of this repository

    In this repository we will be providing shell scripts to measure average Ping & DNS response time from some of the well known DNS servers like 1.10.10.10, 1.1.1.1, 8.8.8.8, 9.9.9.9
