resource "aws_launch_template" "lt" {
  name     = local.lt
  image_id = var.ECS_AMI
  iam_instance_profile {
    arn = aws_iam_instance_profile.iam_instance_profile.arn
  }
  vpc_security_group_ids = [aws_security_group.sg.id,aws_security_group.redis_sg.id]
  instance_type          = var.INSTANCE_TYPE
  update_default_version = true
  block_device_mappings {
    # need to consider at the time of ami change
    device_name = "/dev/xvda"
    ebs {
      volume_size           = 100
      delete_on_termination = true
      encrypted             = false
      volume_type           = "gp2"
    }
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = local.lt_tag
    }
  }
  monitoring {
    enabled = false
  }
  user_data = base64encode(<<-EOF
       #! /bin/bash
       echo ECS_CLUSTER=${var.CLUSTER} >> /etc/ecs/ecs.config;
       mkdir ~/.aws
       touch ~/.aws/credentials
       chmod -R 777 ~/.aws 
       yum install -y wget aws-cli
       echo "[default]" > ~/.aws/credentials
       echo "region = ap-south-1" >> ~/.aws/credentials
       INSTANCE_ID=$(ec2-metadata -i | cut -d ' ' -f 2)
       aws ec2 associate-address --instance-id $INSTANCE_ID  --allocation-id ${var.EIP_ID}

    EOF 
  )
}