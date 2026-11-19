# Multi-Environment Cloud Infrastructure & Governance

## Project Overview
This project automates the creation and security management of AWS cloud infrastructure using Terraform. It is designed to support multiple environments (Dev, Staging, Prod) consistently while catching security issues early and fixing manual configuration drift.

## Tech Stack
* **Infrastructure as Code:** Terraform
* **Cloud Provider:** AWS (VPC, Subnets, EC2, S3, IAM)
* **Security Scanning:** Checkov (via Docker)
* **Version Control:** Git & GitHub

## Key Features Implemented
1. **Reusable Infrastructure:** Used `variables.tf` and dynamic AMI lookups (`data` blocks) so the same code can deploy across different environments.
2. **Shift-Left Security:** Ran Checkov static analysis inside a Docker container to detect misconfigurations (such as missing S3 bucket versioning) and patched them in code.
3. **Configuration Drift Recovery:** Simulated an unauthorized manual change in the AWS Console, detected the drift using `terraform plan`, and automatically restored the approved state with `terraform apply`.
4. **Secure Repo Practices:** Configured `.gitignore` to block local state files (`.tfstate`) and provider caches from being pushed to GitHub.

## How to Run
```bash
terraform init
terraform plan
terraform apply
