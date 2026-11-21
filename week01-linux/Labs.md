


WEEK 2 — MONDAY NETWORKING LAB

1. Ubuntu interface name: eth0:
2. Ubuntu IPv4 address and prefix: 192.168.1.42/24
3. Default gateway: 192.168.1.1
4. Route selected for 1.1.1.1:	1.1.1.1 via 192.168.1.1
5. SSH listening address and port: 0.0.0.0:22
6. nginx listening address and port: 0.0.0.0:80
7. Local HTTP test result:
HTTP/1.1 200 OK
Server: nginx/1.18.0 (Ubuntu)
Date: Thu, 24 Sep 2026 18:08:15 GMT
Content-Type: text/html
Content-Length: 612
Last-Modified: Wed, 16 Sep 2026 18:42:13 GMT
Connection: keep-alive
ETag: "6aaae305-264"
Accept-Ranges: bytes
8. Windows-to-VM port 80 test result:
ComputerName     : 192.168.1.42
RemoteAddress    : 192.168.1.42
RemotePort       : 80
InterfaceAlias   : vEthernet (V_Ethernet)
SourceAddress    : 192.168.1.2
TcpTestSucceeded : True
9. Windows-to-VM port 22 test result:
ComputerName     : 192.168.1.42
RemoteAddress    : 192.168.1.42
RemotePort       : 22
InterfaceAlias   : vEthernet (V_Ethernet)
SourceAddress    : 192.168.1.2
TcpTestSucceeded : True
10. DNS lookup result:
142.250.184.14  STREAM google.com
142.250.184.14  DGRAM
142.250.184.14  RAW

BREAK/FIX SIMULATION
11. What happened when I tested port 65000? Failed to connect to 127.0.0.1 port 65000
12. What did ss show for port 65000? No service is running on port # 65000
13. Why did port 80 behave differently? Becuase the service was activate and running. 
14. What evidence supports my conclusion? Since no service is running on port 65000, it is expcted that connectivity will be failed. 

If nginx is not installed or is inactive, report that as an observation. You do not need to install or reconfigure anything to complete Monday's lesson.

Completion target for today: Finish the observation lab, record your actual results, and explain the port 65000 simulation. Send me your Monday lab report when you're ready; I'll review your evidence and then guide you through Tuesday's DNS and TCP connectivity exercises.


DNS server:   192.168.1.1 and 8.8.8.8
Interface using that DNS server: eth0
google.com resolved IP: 142.250.202.174
HTTP test:
HTTP/2 301
location: https://www.google.com/
content-type: text/html; charset=UTF-8
content-security-policy-report-only: object-src 'none';base-uri 'self';script-src 'nonce-VlafSOVr2LGMG_uF6Hs8IA' 'strict-dynamic' 'report-sample' 'unsafe-eval' 'unsafe-inline' https: http:;report-uri https://csp.withgoogle.com/csp/gws/other-hp
date: Fri, 25 Sep 2026 04:02:28 GMT
expires: Sun, 25 Oct 2026 04:02:28 GMT
cache-control: public, max-age=2592000
server: gws
content-length: 220
x-xss-protection: 0
x-frame-options: SAMEORIGIN
alt-svc: h3=":443"; ma=2592000,h3-29=":443"; ma=2592000



Test-Netconnection <IpAddress> -Port <Port #>
Source IP: 192.168.1.2
Destination IP: 192.168.1.42
Destination port: 65000
TcpTestSucceeded: False

Source IP: 192.168.1.2
Destination IP: 192.168.1.42
Destination port: 80
TcpTestSucceeded: True


TUESDAY LAB

1. DNS
DNS server: 192.168.1.1 8.8.8.8
google.com resolution: 142.250.202.206
Invalid hostname result:  resolve call failed: 'bilal.invalid' not found

2. TCP
Port 22 from Windows:
ComputerName     : 192.168.1.42
RemoteAddress    : 192.168.1.42
RemotePort       : 22
InterfaceAlias   : vEthernet (V_Ethernet)
SourceAddress    : 192.168.1.2
TcpTestSucceeded : True
Port 80 from Windows:
ComputerName     : 192.168.1.42
RemoteAddress    : 192.168.1.42
RemotePort       : 80
InterfaceAlias   : vEthernet (V_Ethernet)
SourceAddress    : 192.168.1.2
TcpTestSucceeded : True
Port 65000 from Windows:
ComputerName           : 192.168.1.42
RemoteAddress          : 192.168.1.42
RemotePort             : 80
InterfaceAlias         : vEthernet (V_Ethernet)
SourceAddress          : 192.168.1.2
PingSucceeded          : True
PingReplyDetails (RTT) : 1 ms
TcpTestSucceeded       : False

3. ROUTING
Route to 8.8.8.8: 8.8.8.8 via 192.168.1.1 dev eth0 src 192.168.1.42 uid 1000
Route to 192.168.1.2: 192.168.1.2 dev eth0 src 192.168.1.42 uid 1000
Why are they different? routing to local network don't use gateway IP address

4. BREAK/FIX
What can I eliminate? Application and service
What do I suspect? Port binding to Ip address
What command(s) would I run next? ss -lntp
Why? to see if port is listening on Server IP address. Becuase port is accessilble using loopback address. 

A1: DNS -> As name is not resoling. 
A2: ss -lntp -> List down the listening ports. ip route tells how TCP traffic will flow from source to Destination
A3: No, it doesn't guarantee becaue there are other aspects also to be considered such as name is resolving or not and routing
A4: It tells that port 80 is accessilble and it proves that nginx will return a valid response. 
A5: NO, since both IP addresses are in same network, it don't need to go through gateway ip address 192.168.1.1
A6: 1) DNS issue -> The server name couldn't be resolved 2) generally tells us that the TCP connection was actively rejected—for a local test, a common reason is that nothing is listening on that address/port.


1. What have I proven about DNS? I have proved that DNS can resolve the hostname

2. What have I proven about routing? I proved that IP address will be reached via specific gateways.

3. What does successful ping tell me? it tell me that server is reachable over ICMP. 

4. Does successful ping prove TCP/443 should work? Why? NO, it doesn't prove because ping is layer 3 protocol and do NOT test TCP connectivity. 

5. Which layer is currently failing? TCP layer. 

6. Give me THREE possible causes. 1) Port is not listening. 2) May be service is down 3) Service may have not set to enabled

7. What evidence would you collect next? list down the listning ports. 


WEDNESDAY LAB

Observed:
1. TCP/80: True
2. TCP/65000: Fail
3. Ping: Success
4. tracepath:

BREAK/FIX
1. DNS conclusion: Resolved
2. Routing conclusion: list hosts will be used to reach destination
3. Ping conclusion: Server is reachable
4. Does ping prove TCP/443? NO, it doesn't prove because ping is layer 3 protocol and do NOT test TCP connectivity. 
5. Failing layer: TCP Layer 4
6. Three possible causes: 1) Port is not listening. 2) May be service is down 3) Service may have not set to enabled
7. Next evidence/commands:list down the listning ports. 

MEMORY
A1: Connection Timeout = Server is not reachable. Connection Refused= Layer 3 is reachable but TCP Port is not listening.
A2: NO, it doesn't prove because ping is layer 3 protocol and do NOT test TCP connectivity. 
A3: it proved that DNS is working fine. However, it doesn't prove that IP address is reachable. 
A4: It tells what gateways  will be used to reach to the IP address.
A5: No. My action would be to validate if specific port is listening or not by using ss -lntp



THURSDAY BREAK/FIX

INCIDENT 1
Symptom: connection failure
First check: check if service is accessilble using curl
Evidence: check nginx service status if it is active or inactive. Check port is is listening or not. check logs from journalctl
Diagnosis: service was inactive. 
Fix: Start nginx service
Verification: Check HTTP connection using curl

INCIDENT 2
Observation on port 8080: the port 8080 is NOT listening
Observation on port 80: the port 80 is listening
Diagnosis: someone is trying to access on wrong port

INCIDENT 3
Invalid hostname result: resolve call failed, host not found
google.com result: host name was resolved
Diagnosis: the hostname couldn't be resolved. The hostname could be incorrect or non-existent one. 
What can I eliminate? Nothing. The host name couldn't be resolved. 

INCIDENT 4
If nginx listens on 127.0.0.1:80:
Why does localhost work? it works because port is binded to loopback IP address 127.0.0.1:80
Why might Windows fail? Because the port 80 is not binded to ubuntu/destination ip address. 
What would I investigate? Check port binding in service configuration file. 

FINAL INCIDENT
1. Eliminated: DNS, routes, ICMP, 
2. Failing layer: TCP layer
3. Three hypotheses: 1) port is not listening on destination server 2) Firewall is blocking the connection on 443 3) The service on host server might be down. 
4. Client-side evidence: check TCP connectivity to the port
5. What remote/network team should check: Check if the service is running or port is listening or firewall is allowing incoming connection
6. Restart server? Why? No. Restart server is not required until they check point # 5)





WEEK 2 — SATURDAY PROJECT

BASELINE
Ubuntu IP: 192.168.1.42
Windows IP: 192.168.1.2
Subnet: 255.255.255.0
Gateway: 192.168.1.1
nginx state: active
nginx listener:  [::]:80
Local HTTP: HTTP/1.1 200 OK
Remote TCP/80:
ComputerName     : 192.168.1.42
RemoteAddress    : 192.168.1.42
RemotePort       : 80
InterfaceAlias   : vEthernet (V_Ethernet)
SourceAddress    : 192.168.1.2
TcpTestSucceeded : True

HEALTHY PACKET CAPTURE
Client IP: 192.168.1.2
Client ephemeral port: 18203
Server IP: 192.168.1.42
Server port: 80
First packet: 04:29:35.180537 eth0  In  IP 192.168.1.2.18203 > 192.168.1.42.80: Flags [S], seq 282428349, win 65535, options [mss 1460,nop,wscale 8,nop,nop,sackOK], length 0
Second packet: 04:29:35.180580 eth0  Out IP 192.168.1.42.80 > 192.168.1.2.18203: Flags [S.], seq 2682219490, ack 282428350, win 64240, options [mss 1460,nop,nop,sackOK,nop,wscale 7], length 0
Third packet: 04:29:35.182112 eth0  In  IP 192.168.1.2.18203 > 192.168.1.42.80: Flags [.], ack 1, win 255, length 0
What does this prove? This proves that Three way handshake was completed and connection was established between client and server. 

INCIDENT A — NGINX STOPPED
Symptom: Service is not reachable. 
Ping: Server IP is reachable over ICMP
TCP/80: TCP connection failed.
Listener: no service is is listening on port 80
Service state: inactive
Relevant logs: journalctl logs shows the service was deactivated and a high performance server was stopped. 
Packet-capture observation: Sync packets are being received, but NO SYN-ACK is happeninng which shows connection is NOT being established/ 
Root cause: nginx service is down on server. 
Fix: Start the nginx Service
Verification: TCP connection is succeeded from Windows

INCIDENT B — WRONG PORT
TCP/80: TCP connection succeeded
TCP/8080: TCP Connection failed. 
Listener evidence: [::]:80
Diagnosis: On server I do NOT see traffic on port 80 from client. Client must have been using different port #. 
Would restarting nginx help? Why? No it will not help because nginx is up and running and listening on port 80. While client was trying to connect on wrong port 8080

FINAL QUESTIONS
1. Difference between nc and tcpdump: nc establishes the Connection ["What happens if I try connecting?"], while tcpdump is used to trace the incoming/outgoing packets ["What packets actually crossed this interface?"].
2. SYN means: Client = I wan to establish Connection
3. SYN-ACK means: Server = I received your connection request
4. RST means: The connection is reset. [I did not read about it yet] 
5. SYN repeatedly sent with no response suggests: _Something_is_silently_dropping/response_isn't_returning_
6. SYN followed by RST suggests: I don't it is explained above. If you have taught me, I might have missed it. If not, please explain it me. 
7. Why doesn't successful ping prove HTTP works? becaue may be port is not listening on server or TCP/IP communication is not allowed yet. 
8. Why doesn't successful TCP/80 prove HTTP works? because it just validate the connectivity that port is reachable and NOT the functionality of the Service.


Scenario 1 — DNS
Q1: What layer would you investigate first? Answer: DNS layer
Q2: Give two commands you'd use. Answer: getent hosts, resolvectl query

Scenario 2 — TCP refusal
Q3: What does this packet evidence tell you? Answer: This tells that incoming packet is rejected. 
Q4: What would you ask the server administrator to check? Answer: We can ask them to check if respective port is listening on the server. 

Q5: Give three reasonable areas to investigate. Answer: Check server or network configuration is allowing specifi port, check filters, remote host behaviour
Q6: Can you conclude that the server firewall is responsible? Why? Answer: 