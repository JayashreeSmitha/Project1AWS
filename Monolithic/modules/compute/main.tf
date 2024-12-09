resource "aws_instance" "web_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.private_subnet_ids[0]  # Use private subnet from `network` module
  tags = { Name = "Web Server" }
}

output "web_server_id" {
  value = aws_instance.web_server.id
}
