# codimite-assignment

This repository contains the code and answers to the written questions from the Codimite assignment

A).  Terraform & Infrastructure-as-Code (IaC)
The Terraform code for questions 1, 2, and 3 is provided in the repository. The answer to question 4 is below.

Automating the Process Using TFActions:

TFActions can be implemented through Continuous Deployment pipelines to streamline and secure the deployment of infrastructure using Terraform.
Version Control with Git: A Git repository (such as GitHub or Bitbucket) is used to store the Terraform code. The main branch represents the current state of all deployed infrastructure. When changes are required, Infrastructure Engineers create a feature branch with the proposed modifications.
Pipeline for Pull Requests: When a Pull Request (PR) is opened to merge the feature branch into the main branch, a CI/CD pipeline is triggered. This pipeline runs the terraform plan command to generate a plan detailing the proposed infrastructure changes. The plan output is added as a comment in the PR for review.
Code Review and Approval: The generated plan is reviewed by a Senior or Lead Engineer. Once approved, the PR is merged into the main branch.
Pipeline for Applying Changes: Upon PR approval and merge, another pipeline is triggered to apply the reviewed changes. This pipeline executes the terraform apply command to implement the infrastructure changes.
Secure State Management: The Terraform state is securely managed using a backend such as a GCS bucket, ensuring consistency and security throughout the process.
CI/CD Tools: Tools like Jenkins, GitHub Actions, or any other CI/CD platform are used to implement this workflow, providing flexibility based on the team's preferences and infrastructure setup.

B). GCP Concepts & Networking

A high-level architecture diagram showing the networking setup for question 1, 
which can be accessed through the following URL: https://github.com/BUWNK/codimite-assignment/blob/main/GCPConcepts%20%26%20Networking.png
The answer to question 2 is below.

 How You Would Secure the Setup

1.By placing GKE, Redis, and CloudSQL in private subnets, these services are shielded from direct internet exposure. The public-facing CLB acts as a controlled entry point, forwarding traffic only to GKE through secure, predefined rules.
2.Implement RBAC (Role-Based Access Control) for the GKE cluster to define roles and permissions for users, ensuring they only have access to the necessary resources.
3.Allow access to the GKE control plane only through a VPN connection or a private endpoint.
4.Firewall rules restrict inbound and outbound traffic to only necessary IPs, protocols, and ports.
5.Use Service Accounts with minimal permissions for applications within the GKE cluster. Make sure each service has access only to the resources it needs, using IAM roles and policies.
6.Enable VPC Flow Logs to monitor network traffic for suspicious activities and potential misconfigurations.
7.Private Google Access is enabled for your private subnet, allowing GKE nodes to access Google Cloud APIs (like CloudSQL) through private IPs.
8.Ensure that all communication between services (e.g., GKE to CloudSQL and Redis) is encrypted using TLS or SSL.
9.Enable encryption at rest for CloudSQL and Redis, and ensure that the appropriate keys are managed securely via Cloud Key Management.
10.Enable audit logs for both CloudSQL and Redis to track and monitor access and configuration changes.

How you would optimize costs while maintaining high availability.

1.Implement cross-region replication for CloudSQL and Redis to ensure data redundancy.
2. Set up a standby GKE cluster in another region with minimal nodes, ready to scale during failover (DR).
3. Consolidate multiple workloads behind a single Cloud Load Balancer to reduce the cost of maintaining separate load balancers for each service.
4. Configure GKE as a regional cluster instead of a zonal cluster to improve high availability without additional costs for failover infrastructure.
5. Use GKE auto-scaling to dynamically adjust the number of nodes based on workload demand, minimizing costs during low traffic periods.
6. Deploy the GKE cluster in multiple zones within the same region to handle zonal failures while avoiding inter-region latency and costs.

C). CI/CD & GitHub Actions

The GitHub Actions workflow YAML file for questions 1, 2, and 3 is provided in the repository: https://github.com/BUWNK/codimite-assignment/blob/main/.github/workflows/docker-publish.yml . 
The answer to question 4 is provided below.

Explain how you configure the deployment through ArgoCD

ArgoCD is a declarative, GitOps-based continuous delivery tool for Kubernetes that uses the pull method. To get started, we have to ensure ArgoCD is installed on the GKE cluster. Next, install the ArgoCD CLI on your local machine and log in to ArgoCD.

Once logged in, define an ArgoCD application to manage your GKE deployment. This application should point to the Git repository where your Kubernetes manifests are stored. After the Docker image is pushed to GCR through your GitHub Actions workflow, the ArgoCD application will automatically sync and deploy the updated image to the GKE cluster. This functionality is enabled by configuring the automated sync policy in the ArgoCD application YAML.

D). Security & Automation Guardrails

A sample Conftest policy that ensures all Terraform code includes encryption for GCS buckets and restricts the project for question 1 is included in the repository's gcs_encryption.rego file at the following URL.
https://github.com/BUWNK/codimite-assignment/commit/d106ca3abf65ec921c50c241caa1c4383166b429

The Trivy command to scan a Docker image during a GitHub Actions pipeline for question 2 is included in the GitHub Actions workflow YAML file. URL:
https://github.com/BUWNK/codimite-assignment/blob/main/.github/workflows/docker-publish.yml

E). Problem-Solving & Troubleshooting Scenario

First, we need to examine the logs of the affected pods in GKE and ensure that any network policies within GKE are not restricting communication between the application pods and CloudSQL. Next, verify CloudSQL connectivity to ensure it is reachable from within the cluster. If connectivity is not established, we need to check the firewall rules in Google Cloud to ensure that the CloudSQL instance allows traffic from the GKE nodes. Additionally, review the CloudSQL logs for any errors. It's also important to confirm that GKE nodes have proper outbound access to the CloudSQL instance. Ensure the proper IAM roles are assigned, and as a best practice, implement circuit breakers or retries to handle any intermittent issues.


