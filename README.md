<h2>Radar</h2>

Radar is a simple network port scanner written in Nim. This program allows you to scan a specific IP address and check which ports are open, with the ability to choose from different scanning modes.
Features

    Scan specific ports or a range of common ports.
    Verbose mode to show more details during the scan.
    Easy to use with command-line flags.
    
Prerequisites to compile:

    You must have Nim installed on your machine. If you don’t have it installed, follow the instructions on Nim's official website to install it.

How to Compile the Program:

    Git clone or manually copy Radar's source code into a folder on your machine and navigate to it in the terminal

    Run the following command to compile the program:
  
    nim compile --run radar.nim
    
    This will then compile and you will be able to immediately run radar.


How to use Radar:

Once Radar is running, it will ask you to provide an IP address and choose a scanning flag. Here's how to use it:
Basic Flow

    Enter the IP address to scan.
        Example: 127.0.0.1 or 192.168.1.1:80,443 (if you want to scan specific ports).
    Choose a scan mode by entering one of the following flags:
        -n: Normal scan (scans the most common ports: 80, 443, 22, 8080, 3306).
        -udp: UDP scan (scans common UDP ports like 53, 67, 111, 161, 162).
        -tcp: TCP scan (scans common TCP ports like 22, 25, 53, 70, 80, 113, 443).
        -all: Full scan (scans a wide range of common ports: 20, 21, 22, 23, 25, 53, 67, 80, 443, 110, 135, 139, 445, 1433, 3306, 3389, 8080).
    Optionally, enable ve![Screenshot 2024-12-07 204233](https://github.com/user-attachments/assets/758a88fb-141f-4702-b02f-4718f8154a46)
rbose mode to get more detailed information about each connection attempt. You will be asked if you want verbose output. (Currently working on implementing verbose out better)

![Screenshot 2024-12-07 204233](https://github.com/user-attachments/assets/21b5619f-cdc9-45de-9a31-99877accd9d8)


    
    
