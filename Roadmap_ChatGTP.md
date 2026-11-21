
# Your DevOps Learning Map

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

# 1. Skill decomposition
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

# 2. Your weekly learning system
| Session | Duration | Purpose |
|---|---:|---|
| Monday | 45 min | Learn |
| Tuesday | 60 min | Guided lab |
| Wednesday | 45 min | Recall + troubleshoot |
| Thursday | 60 min | Hands-on |
| Saturday | 2 hr 30 | Project/deep work |
| Sunday | 60 min | Review + documentation |
| **Total** | **7 hrs** | |

PHASE 1 — FOUNDATION - Weeks 1–4
Week 1 — Linux:
	Filesystem
	permissions
	users/groups
	processes
	systemd
	SSH
	packages
	logs
	environment variables
	Exercises
	Install Ubuntu Server VM.
	Create users.
	Configure SSH.
	Install nginx.
	Create service.
	Stop nginx.
	Diagnose why website isn't reachable.
	Find logs.
	Change permissions.
	Create cron job.
Week 2 — Networking for DevOps:
	Learn:
	TCP/IP
	DNS
	HTTP/HTTPS
	TLS
	ports
	routing
	NAT
	firewalls
	load balancing
Week 3 — Git/GitHub
	repository
	commit
	branch
	merge
	pull request
	remote
	.gitignore
	Exercise Create:
Week 4 — Bash + Python automation
PHASE 2 — APPLICATION | Weeks 5–8: Now we introduce containers and CI/CD.
Week 5 — Docker fundamentals
	Learn:
	image
	container
	Dockerfile
	registry
	volume
	network
	port mapping
	environment variables
Week 6 — Docker Compose
	Learn:
	Compose
	networks
	volumes
	health checks
	environment variables
	secrets basics
	Failure practice
	Delete container.
	Restart it.
	Database data should survive.
	Break database credentials.
	Diagnose using logs.
	SHOW:
	Multi-container application.
Week 7 — CI/CD
	Learn the pipeline:
	Build pipeline:
Week 8 — Integration
	Combine:
	Git
	Python
	Docker
	CI/CD
	Linux
	WEEK 8 TEST:
		Give yourself 2 hours.
		You receive a Python application.
		Without following a tutorial:
		Containerize it.
		Create Docker Compose.
		Push to GitHub.
		Build a CI workflow.
		Deploy:
		Then deliberately break the container and troubleshoot it.
		If you cannot do this, don't proceed to Kubernetes yet.
		Repeat weeks 5–8 where necessary.
PHASE 3 — INTERMEDIATE Weeks 9–12: Now Infrastructure as Code + AWS. This phase should leverage your AWS SAA knowledge instead of repeating certification theory.
Week 9 — Terraform
	providers
	resources
	variables
	outputs
	state
	plan
	apply
	destroy
	SHOW:
	Provision EC2 using Terraform.
	Destroy it.
	Rebuild it.
Week 10 — Terraform architecture
Week 11 — AWS DevOps architecture
Weeks 13–14
	Kubernetes architecture. Understand:
	Control plane
	worker nodes
	API server
	etcd
	scheduler
	controller
	kubelet
	Then:
	Pods
	Deployments
	ReplicaSets
	Services
	SHOW:
	Deploy your Docker application to Minikube/kind.
Weeks 15–16
	ConfigMaps
	Secrets
	Namespaces
	Volumes
	Persistent Volumes
	Ingress
	DNS
Weeks 17–18 — Kubernetes troubleshooting
	image
	DNS
	service
	selector
	secret
	config
	resource limit
	readiness probe
Weeks 19–20 — Helm + EKS
	Learn Helm.
	Then move from local Kubernetes to AWS EKS.
	Deploy your existing application.
Weeks 21–22 — Observability
	Prometheus
	Grafana
	CloudWatch
	logs
	metrics
	alerts
Weeks 23–24 — Security + SRE
	least privilege
	IAM
	Kubernetes RBAC
	secrets
	container scanning
	backup
	health checks
	readiness/liveness
	SLI/SLO basics
	incident response

# 7. Your 15-minute daily habit
Even on days when you cannot study:
5 minutes — Recall
Write three things learned recently without looking.
5 minutes — Command
Run 2–3 commands.
5 minutes — Explain
Pick one concept:
"What is Terraform state?"

Explain it aloud as though teaching a junior engineer.

That's enough to keep knowledge active.