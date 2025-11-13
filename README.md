# Create in Aws a fargate with terraform
This project automates the deployment of a scalable containerized application using Amazon ECS with Fargate. It includes all necessary infrastructure components: ECS clusters, task definitions, services, load balancers, and auto-scaling policies. Managed with Terraform, it supports dynamic scaling based on CPU and memory usage to handle workload fluctuations efficiently. Additionally, it ensures secure communication via SSL/TLS, and Docker images are stored in Amazon ECR for fast, reliable deployments. <br>
The repository structure has been reorganized to enhance maintainability and scalability, grouping resources by modules and AWS functionalities.

### Diagram
<img src="diagram/diagram.png" alt="Logo del proyecto" width="400" height="450">

#### Repository version
2.0.0