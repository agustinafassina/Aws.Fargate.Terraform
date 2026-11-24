### Aws Configuration ###
region  = "sa-east-1"
vpc_id  = "vpc-xxxxxx"
subnets = ["subnet-xxxxxx", "subnet-xxxxxx"]

### Profile configuration ###
profile = "xxxxxx"

### ECS services configuration ###
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