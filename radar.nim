import net

# Checks if a specific port is open on the given IP address
proc scanPort(ip: string, port: int) =
  try:
    # Create a socket object to make the connection
    var sock = Socket()
    
    # Try to connect to the given IP and port (cast port to Port type)
    sock.connect(ip, Port(port))  # cast port to Port type
    
    echo "Port ", port, " is open on ", ip
    sock.close()  # close the socket when done
  except OSError as e:  # If there's a connection error, catch it
    echo "Port ", port, " is closed on ", ip, ": ", e.msg  # show an error if port is closed or blocked

# Scan a list of ports on the target host
proc scanHost(ip: string, ports: seq[int]) =
  echo "Scanning host: ", ip
  for port in ports:
    scanPort(ip, port)

#==================================================================
# Main function to start the scan
proc main() =
  let targetIP = "127.0.0.1"  # Put the IP you want to scan here
  let ports = @[80, 443, 22, 8080, 3306]  # ports you want to check

#==================================================================

  scanHost(targetIP, ports)

main()
