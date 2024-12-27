# Security Group for the EC2 instance
resource "aws_security_group" "allow_all" {
  name_prefix = "allow_all_"
  description = "Allow all inbound traffic"
  vpc_id      = "vpc-01f36841f626bb724"
  #vpc_id      = "vpc-0834622e739bd40af"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Launch template for the EC2 instances
resource "aws_launch_template" "ubuntu_template" {
  name_prefix   = "ubuntu-template"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = "Coffee"

  network_interfaces {
    associate_public_ip_address = true
    security_groups            = [aws_security_group.allow_all.id]
  }
}

# Auto Scaling Group for launching EC2 instances
resource "aws_autoscaling_group" "ubuntu_asg" {
  desired_capacity     = 1
  max_size             = 1
  min_size             = 1
  launch_template {
    id      = aws_launch_template.ubuntu_template.id
    version = "$Latest"
  }
   vpc_zone_identifier = ["subnet-0e0a6afe542f230e7", "subnet-0d5aa884f37136027"]
  #vpc_zone_identifier = ["subnet-00c3ea5a8773d3733", "subnet-02953b6365416d066"]
  health_check_type  = "EC2"
  health_check_grace_period = 300
  wait_for_capacity_timeout = "0"
}