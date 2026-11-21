                    DEVOPS ENGINEER
                         │
        ┌────────────────┼────────────────┐
        │                │                │
      Linux            Cloud          Automation
        │                │                │
   Networking           AWS           Python/Bash
        │                │                │
        └────────── Git / GitHub ─────────┘
                         │
                       Docker
                         │
                  CI/CD Pipelines
                         │
                      Terraform
                         │
                    Kubernetes
                         │
               Monitoring / Logging
                         │
              Security + Reliability
                         │
                PLATFORM ENGINEERING
                         │
                AI INFRASTRUCTURE


| # | Skill | Why it matters | Hours | Prerequisite | Competency test |
|---|---|---|---:|---|---|
| 1 | Linux + Networking | Foundation underneath almost everything | 25 | Existing IT | Troubleshoot Linux/network issues without tutorials |
| 2 | Git + GitHub | Version-controlled engineering workflow | 15 | None | Branch, merge, PR, revert, resolve conflict |
| 3 | Python + Bash | Automation | 30 | Linux | Automate an admin task/API workflow |
| 4 | Docker | Application packaging/runtime | 30 | Linux | Containerize multi-service application |
| 5 | CI/CD | Automated build/test/deploy | 25 | Git + Docker | Build pipeline from commit → deployment |
| 6 | Terraform + AWS | Infrastructure as Code | 45 | AWS/networking | Build AWS environment without console |
| 7 | Kubernetes | Modern orchestration | 60+ | Docker/networking | Deploy/debug/scale an application |
| 8 | Observability/Security/SRE | Production operations | 35+ | Everything above | Detect, diagnose and recover from failures |

Directories

/etc > Store configurations
/var/logs > Store application logs
/tmp > Temporary files
/home > user data 
/opt > Optional
/proc > Process / Kernal related

Process Vs Services:
A process is a running program.
A service is usually a long-running process managed by the operating system.
A process is an instance of a running program. A service is an application/process intended to provide a function, usually in the background, and is commonly managed by a service manager such as systemd.


systemd: [Service Manager]
systemctl status nginx
systemctl start nginx
systemctl stop nginx
systemctl restart nginx
systemctl enable nginx

Practice: 

pwd
ls -la
cd /etc
ls
cd /var/log
ls
ps aux
systemctl --type=service --state=running

Where would nginx configuration probably live? Answer: /etc/nginx directory
Where would nginx logs probably live? Answer: /var/log directoy
How would you find whether nginx is running? Answer: by using command: systemctl status nginx
What is the difference between a process and service? Answer: Process is a running program and Service is long running program
Why did the first edit work, why did the second fail, and why did the third work? For me it chmod didn't fail. See commands for reference below

Permission Map:
| Permission | Letter | Numeric |
| ---------- | ------ | ------: |
| Read       | `r`    |   **4** |
| Write      | `w`    |   **2** |
| Execute    | `x`    |   **1** |
| Nothing    | `-`    |   **0** |

So:
rwx = 4 + 2 + 1 = 7
rw- = 4 + 2 + 0 = 6
r-x = 4 + 0 + 1 = 5
r-- = 4 + 0 + 0 = 4
--- = 0 + 0 + 0 = 0

Therefore:
-rw-r-----
 │  │  │
 │  │  └── --- = 0
 │  └───── r-- = 4
 └──────── rw- = 6

chmod 640 filename

0 = ---
1 = --x
2 = -w-
3 = -wx
4 = r--
5 = r-x
6 = rw-
7 = rwx

644 >> common for normal files
755 >> commnon for executable scripts/directories
600 >> useful for sensitive files such as private keys

File permissions control what you can do with the file. Directory permissions control what you can do with entries inside the directory.

For Files:
r = read file
w = modify file
x = execute file

For Directories:
r = list directory contents
w = create/delete/rename entries
x = enter/traverse the directory

For: 
-rwxr-x--- devops developers deploy.sh
the mapping is: 
Owner:  devops       rwx = 4+2+1 = 7
Group:  developers   r-x = 4+0+1 = 5
Others:               --- = 0
Numeric permission = 750 ✓

Lesson — Logs:
journalctl is a command-line utility used to query and view system logs in Linux distributions that use the systemd system and service manager.
instead of writing logs to multiple scattered plain-text files (like the old /var/log/syslog), modern Linux systems use a background service 
called systemd-journald to collect logs from the kernel, system services, and applications. 
It stores them in a centralized, indexed binary format. Because these logs are binary, you cannot read them with standard text tools like cat or nano; 
instead, you use journalctl to safely parse and read them\

For DevOps, logs are evidence.

journalctl
journalctl - u nginx
journalctl -u nginx --since "10 minutes ago" [recent]
journalctl -u nginx --since "10 minutes ago" [follow live]
tail -f /var/log/syslog [depending on distribution]
sudo journalctl -u nginx -n 30 --no-pager


sudo ss -lntp [List Port]
Option		Meaning
-l		Show listening sockets
-n		Show numeric IP addresses and ports
-t		Show TCP sockets
-p		Show associated processes, where permitted


# Week 2:  Linux Networking Fundamentals
## Identify the VM's network interface and IP address
ip -br addr // ip -4 addr show
## Inspect the routing table
ip route // ip route get 1.1.1.1
tracepath 8.8.8.8
curl -Iv --max-time 10 https://<host> [testing beyond basic TCP connectivity.]
nc -vz -w 5 10.20.30.40 443 [test reacability of port] [Can I establish a connection to TCP/443 on 10.20.30.40?”]
| Part | Meaning |
|---|---|
| `nc` | Netcat |
| `-v` | Verbose output |
| `-z` | Connection/port scan mode without sending normal application data |
| `-w 5` | Wait up to 5 seconds |
| `<host>` | Destination hostname/IP |
| `443` | Destination TCP port |


## Inspect listening TCP ports
ss -lntp
Listening address	Interpretation
127.0.0.1:80		Accepts IPv4 connections through the local loopback interface only
0.0.0.0:80			Listens on all local IPv4 addresses
192.168.1.50:80		Listens on that specific local IPv4 address	
[::]:80				Listens on IPv6 addresses; IPv4 behavior depends on socket configuration

sudo ss -lntp '( sport = :65000 ) _Checks if specific port is running on the server_
## Compare local and remote HTTP connectivity
curl -I --max-time 5 http://127.0.0.1
curl -I --max-time 5 http://<VM_IP>
Test-NetConnection <VM_IP> -Port 80 _Powersheell [Windows]_
nc -vz -w 5 <host> 443 [test reacability of port]

## Inspect DNS without changing it
resolvectl status >> _shows_resolver_configuration_, if your system uses systemd-resolved_
resolvectl query ubuntuserver.local >>
getent ahostsv4 example.com >> _asks the system to resolve the hostname to IPv4 addresses_
getent hosts myserver.local 


| Question | Useful command |
|---|---|
| Can Linux resolve the hostname? | `getent hosts`,`getent ahostsv4`, `resolvectl query` |
| Which route would Linux use? | `ip route get` |
| Is the local service listening? | `ss -lntp` |
| Can I establish TCP connectivity? | `nc -vz` / Windows `Test-NetConnection` |
| Does HTTP actually work? | `curl` |
| Is the service healthy? | `systemctl status` |
| What happened to the service? | `journalctl` |

The biggest lesson to retain is this troubleshooting ladder:

NAME
 ↓
DNS
 ↓
IP / ROUTE
 ↓
TCP
 ↓
APPLICATION PROTOCOL
 ↓
APPLICATION

Completed: DNS → Routing → TCP → Application protocol → Application

## Network Troubleshooting
*Focus: refused vs timeout, ICMP/ping, route/path analysis, and evidence collection.*

timeout -> distination is not reachable [firewall issue etc]
refuesd -> port is NOT listening

DNS -> Resolve DNS [getent hosts <example.com>]
 ↓
ROUTE -> What route will be used? [ip route <IP Address>]
 ↓
TCP -> If tcp port is accessible [nc -vz -w 5 <host> 443]
 ↓
PROTOCOL -> for HTTPS [curl -Iv --max-time 10 https://<host>]
 ↓
APPLICATION


| Evidence | What you can conclude |
|---|---|
| DNS resolves | Name → IP works |
| Route exists | Linux knows how it intends to send traffic |
| Ping succeeds | ICMP/IP communication succeeded |
| TCP connects | TCP connection to that IP:port succeeded |
| TCP refused | Connection was actively rejected; often no listener |
| TCP timeout | Expected TCP response wasn't received in time |
| HTTP 200 | HTTP application responded successfully |

sudo tcpdump -ni any tcp port 80 	Think of tcpdump as a command-line Wireshark. It lets you observe packets entering and leaving the server.
| Part | Meaning |
|---|---|
| `sudo` | Packet capture normally requires elevated privileges |
| `tcpdump` | Capture/display packets |
| `-n` | Don't resolve IPs/ports into names |
| `-i any` | Capture on all available interfaces |
| `tcp` | Only TCP traffic |
| `port 80` | Only traffic where source or destination port is 80 |

[S] --> SYN --> Client says I want to establish a TCP connection.
[S.] --> SYN-ACK --> Server: I received your request and I'm willing to establish the connection.
[.] --> ACK --> Client acknowledges.
[P.] -->  --> 
[F.] -->  --> 
[R.] -->  --> 

TCP three-way handshake
Client                     Server
  │                           │
  │ -------- SYN -----------> │
  │                           │
  │ <----- SYN-ACK ---------- │
  │                           │
  │ -------- ACK -----------> │
  │                           │
      CONNECTION ESTABLISHED

nc = test
tcpdump = evidence