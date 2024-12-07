import os, strutils, sequtils, net

# Helper function to print messages if verbose mode is enabled
proc verbosePrint(verbose: bool, msg: string) =
  if verbose:
    echo msg

# Function that tries to connect to a given IP and port
# It will report whether the port is open or closed
proc scanPort(ip: string, port: int, verbose: bool) =
  try:
    # Create a socket and try to connect to the IP:port
    var sock = Socket()
    
    # Attempt to connect to the given port
    sock.connect(ip, Port(port))  # Cast port to Port type
    
    verbosePrint(verbose, "Successfully connected to port " & $port & " on " & ip)
    echo "Port ", port, " is open on ", ip
    sock.close()  # Always close the socket after use
  except OSError as e:
    verbosePrint(verbose, "Error connecting to port " & $port & " on " & ip)
    echo "Port ", port, " is closed on ", ip, ": ", e.msg  # Print the error if port is closed or blocked

# Function to go through a list of ports and scan them on a given host
proc scanHost(ip: string, ports: seq[int], verbose: bool) =
  echo "Starting scan on host: ", ip
  for port in ports:
    scanPort(ip, port, verbose)

# Function to process the user input, including IP, ports, and flags
proc parseFlagsAndInput(verbose: bool) =
  # Ask user for the IP address to scan
  echo "Enter the IP address to scan (e.g., 127.0.0.1:80 (multiple ports can be set with commas) or just 127.0.0.1): "
  var userInput = readLine(stdin)
  
  var ip = ""
  var ports: seq[int] = @[]
  var scanFlag = ""

  # If user provided a port, split the input to get IP and ports
  if ':' in userInput:
    let parts = userInput.split(":")
    ip = parts[0]
    ports = parts[1].split(",").mapIt(parseInt(it))  # Convert comma-separated port string into an array of ints
  else:
    ip = userInput
    echo "No ports specified. Choose a flag (-n, -udp, -tcp, -all):"
    scanFlag = readLine(stdin).strip()  # Strip any unnecessary spaces

  # TODO: Validate IP format to make sure it's correct
  # Check the flag and set default ports based on it
  case scanFlag
  of "-n":
    verbosePrint(verbose, "Running normal scan on " & ip)
    ports = @[80, 443, 22, 8080, 3306]  # Normal ports for web and SSH
  of "-udp":
    verbosePrint(verbose, "Running UDP scan on " & ip)
    ports = @[53, 67, 111, 161, 162]  # Common UDP ports
  of "-tcp":
    verbosePrint(verbose, "Running TCP scan on " & ip)
    ports = @[22, 25, 53, 70, 80, 113, 443]  # Common TCP ports
  of "-all":
    verbosePrint(verbose, "Running all ports scan on " & ip)
    ports = @[20, 21, 22, 23, 25, 53, 67, 80, 443, 110, 135, 139, 445, 1433, 3306, 3389, 8080]  # Most common ports
  else:
    echo "Unknown flag, using default ports: [80, 443, 22, 8080, 3306]"
    ports = @[80, 443, 22, 8080, 3306]  # Default ports if no flag is provided

  # TODO: Validate that the flag entered is one of the valid options (-n, -udp, -tcp, -all)
  # Ask if the user wants verbose output
  echo "Enable verbose output? (y/n):"
  var verboseChoice = readLine(stdin).strip()
  let isVerbose = verboseChoice == "y"  # Set verbose mode based on user input

  # Scan the host with the selected ports and verbose flag
  scanHost(ip, ports, isVerbose)

# Main function to start the scanning process
proc main() =
  echo "Welcome to Nim Scanner!"  # Greet the user
  
  # Run the flag parsing function to begin the scan
  parseFlagsAndInput(true)  # true here enables verbose by default (can be changed by user)

main()
