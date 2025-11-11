resource "aws_security_group" "security_group" {
  name        = local.ecs_security_group_name
  description = "Fargate security group"

  ingress {
    description      = "HTTP desde anywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}