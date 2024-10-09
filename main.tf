resource "aws_instance" "wp_web" {
  ami                    = "ami-0d081196e3df05f4d"
  instance_type          = "t2.micro"
  key_name               = "tf-key"
  vpc_security_group_ids = [aws_security_group.mysecuritygroup.id]
  subnet_id              = aws_subnet.mysubnet_1a.id
  tags = {
    Name = "WP EC2"
  }
}

resource "null_resource" "web-server" {
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("tf-key.pem")
    host        = aws_instance.wp_web.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install httpd -y",
      "sudo yum install php php-mysqlnd php-gd php-xml php-mbstring -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "sudo wget -c https://wordpress.org/wordpress-6.5.tar.gz",
      "sudo tar -xzvf wordpress-6.5.tar.gz",
      "sudo rsync -av wordpress/* /var/www/html/",
      "sudo chown -R apache:apache /var/www/html/",
      "sudo chmod -R 755 /var/www/html/",
      "sudo rm -f /var/www/html/index.html",
      "sudo systemctl restart httpd",
    ]
  }
}

resource "aws_db_instance" "wordpress_db" {
  allocated_storage      = 10
  engine                = "mysql"
  engine_version        = "8.0.35"  
  instance_class        = "db.t3.micro"
  db_name               = var.db_name
  username              = var.db_username
  password              = var.db_password
  db_subnet_group_name  = aws_db_subnet_group.wordpress_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = true
}

resource "aws_db_subnet_group" "wordpress_db_subnet_group" {
  name       = "wordpress-db-subnet-group"
  subnet_ids = [aws_subnet.myprivatesubnet_1a.id, aws_subnet.myprivatesubnet_1b.id]

  tags = {
    Name = "wordpress-db-subnet-group"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Allow MySQL inbound traffic"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
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

resource "null_resource" "wp-config" {
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("tf-key.pem")
    host        = aws_instance.wp_web.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php",
      "sudo sed -i 's/database_name_here/${var.db_name}/g' /var/www/html/wp-config.php",
      "sudo sed -i 's/username_here/${var.db_username}/g' /var/www/html/wp-config.php",
      "sudo sed -i 's/password_here/${var.db_password}/g' /var/www/html/wp-config.php",
      "sudo sed -i 's/localhost/${aws_db_instance.wordpress_db.endpoint}/g' /var/www/html/wp-config.php",
      "sudo systemctl restart httpd",
    ]
  }
}
