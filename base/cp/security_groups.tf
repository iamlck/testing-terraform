resource "aws_security_group" "sg" {
  name        = local.sg
  description = "Allow Traffic"
  vpc_id      = var.VPC_ID
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    security_groups = [ var.LOAD_BALANCER_SG ]
  }
  
  tags = {
    Name = local.sg_tag
  }
}

resource "aws_security_group" "redis_sg" {
  name        = local.redis_sg
  description = "Allow Traffic"
  vpc_id      = var.VPC_ID
  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = local.sg_tag
  }
}