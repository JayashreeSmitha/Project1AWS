resource "aws_db_instance" "db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  db_instance_class    = "db.t2.micro"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_identifier  = "my-db-instance"
  db_name              = "mydb"
  username             = "admin"
  password             = "password"
  vpc_security_group_ids = [var.db_sg_id]
  db_subnet_group_name = var.db_subnet_group_name
  tags = { Name = "MyDB" }
}

output "db_instance_id" {
  value = aws_db_instance.db.id
}
