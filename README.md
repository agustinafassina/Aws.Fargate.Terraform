# ☁️ AWS Fargate with Terraform
Terraform project to deploy one or more Docker services on **Amazon ECS Fargate**. It provisions a shared ECS cluster per workspace, one ECS service per Docker app, task definitions, security groups, CloudWatch Logs, IAM roles, and ECR repositories.

Resources are organized into modules by AWS service to keep the configuration maintainable and easy to extend.

## 🏗️ Architecture
The stack creates:
| Resource | Description |
| --- | --- |
| ECS Cluster | Shared Fargate cluster for the project/environment |
| ECS Services | One service per Docker entry in `services` |
| ECS Task Definitions | Container specs generated with `jsonencode(...)` |
| Security Groups | One security group per service |
| CloudWatch Logs | One log group per service |
| IAM Roles | Separate execution role and task role |
| ECR Repositories | One repository per service |

State is stored remotely in **S3** (`backend.tf`).

### 📊 Diagram
<img src="diagram/diagram.png" alt="Architecture diagram" width="400" height="450">

## 📋 Requirements
- [Terraform](https://developer.hashicorp.com/terraform/install) `>= 1.15.0, < 2.0.0`
- AWS Provider `>= 5.0.0, < 7.0.0`
- AWS account with permissions to manage ECS, ECR, IAM, EC2 (security groups), and S3
- An existing VPC and subnets
- AWS credentials configured through an AWS profile, environment variables, or an assumed role

## 📁 Project structure
```
.
├── main.tf                 # Root module and provider
├── variables.tf            # Input variables
├── backend.tf              # S3 remote state
├── example.tfvars          # Example variable values
├── modules/
│   ├── ecs-cluster/        # Shared ECS cluster
│   ├── ecs-service/        # ECS service, task definition, SG, logs
│   ├── ecr/                # ECR repository
│   └── iam/                # ECS execution and task roles
└── diagram/                # Architecture diagram
```

## ⚙️ Configuration
1. Copy the example variables file:

```bash
cp example.tfvars dev.tfvars
```

2. Edit `dev.tfvars` with your AWS values and Docker services:
```hcl
region  = "sa-east-1"
vpc_id  = "vpc-xxxxxx"
subnets = ["subnet-xxxxxx", "subnet-xxxxxx"]
profile = "your-aws-profile"

services = {
  api = {
    image          = "account-id.dkr.ecr.sa-east-1.amazonaws.com/api:latest"
    container_port = 80
    cpu            = 1024
    memory         = 2048
    desired_count  = 1

    environment_variables = {
      APP_ENV = "dev"
    }
  }

  worker = {
    image         = "account-id.dkr.ecr.sa-east-1.amazonaws.com/worker:latest"
    cpu           = 512
    memory        = 1024
    desired_count = 1
  }
}
```

> `dev.tfvars` is listed in `.gitignore` to avoid committing sensitive or environment-specific values.

Resource names are built from the Terraform workspace and the `profile` variable (e.g. `tf-dev-test-ecs`).

## 🧩 Multi-service model
Use one ECS cluster for the same project/environment and add new Docker workloads as new entries in `services`.

- Use a new `services` entry when the Docker belongs to the same project and environment.
- Use a new cluster when the workload belongs to another project, AWS account, VPC, environment, or requires strong isolation.
- Omit `container_port` for workers or background jobs that do not receive inbound traffic.
- If `image` is omitted, Terraform still creates the service ECR repository and uses that repository URL with `image_tag`.

## 🚀 Usage
Initialize Terraform and download providers:

```bash
terraform init
```

Create or select a workspace (used as the environment name):

```bash
terraform workspace select dev
# or
terraform workspace new dev
```

Review and apply changes:

```bash
terraform plan  -var-file=dev.tfvars
terraform apply -var-file=dev.tfvars
```

Destroy infrastructure:

```bash
terraform destroy -var-file=dev.tfvars
```

Format and validate the configuration:

```bash
terraform fmt -recursive
terraform validate
```

## 💡 Notes
- Each service can define `image`, `container_port`, `cpu`, `memory`, `desired_count`, `environment_variables`, `secrets`, `ingress_cidr_blocks`, `assign_public_ip`, and `log_retention_in_days`.
- For development, services default to `assign_public_ip = true`.
- For production, prefer private subnets, restricted security groups, and an Application Load Balancer for public HTTP traffic.
- Secrets should be referenced from AWS Secrets Manager or SSM Parameter Store using the `secrets` map.
- Adjust `backend.tf` (S3 bucket, region, key) to match your remote state setup.

## 🏷️ Version
```
2.0.0
```