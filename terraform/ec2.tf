# Create a security group for the Application
resource "aws_security_group" "app_sg" {
  vpc_id      = aws_vpc.main_vpc.id
  name        = "Django App SG"
  description = "Allows SSH, HTTP, ICMP access"

  # Allows SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allows HTTP access from anywhere 
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allows ICMP access from anywhere 
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allows outbound Internet access from anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Django_App_sg"
  }
}


# Create a security group for the Database
resource "aws_security_group" "db_sg" {
  vpc_id      = aws_vpc.main_vpc.id
  name        = "Database Django App SG"
  description = "Allows SSH, 5432 port, ICMP access"

  # Allows SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allows 5432 port access from anywhere 
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allows ICMP access from anywhere 
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allows outbound Internet access from anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Database_Django_App_sg"
  }
}

#####################################################################
# Create the application servers
resource "aws_instance" "app_server" {
  count                  = 2
  ami                    = var.instance_ami
  instance_type          = var.app_instance_type
  subnet_id              = aws_subnet.private_subnet[count.index].id
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ssm-iam-profile.name

  tags = {
    Name = "Application Server ${count.index + 1}"
  }
}

# Create the database server
resource "aws_instance" "db_server" {
  count                  = 1
  ami                    = var.instance_ami
  instance_type          = var.db_instance_type
  subnet_id              = aws_subnet.private_subnet[count.index].id
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ssm-iam-profile.name

  tags = {
    Name = "Database Server"
  }
}
