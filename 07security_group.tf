resource "aws_security_group" "sg_workspacePro_application_loadbalancer" {
  vpc_id      = aws_vpc.workspacePro_vpc.id
  name        = "sg_workspacePro_application_loadbalancer"
  description = "Allow  and http to web server"
  ingress {
    description = "http for ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "https for ingress"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "sg-workspacePro-application-loadbalancer", "created-by" = "terraform", Environment = "dev"
  }
}

resource "aws_security_group" "sg_workspacePro_application" {
  vpc_id      = aws_vpc.workspacePro_vpc.id
  name        = "sg_workspacePro_application"
  description = "Allow ssh and http to web server"
  ingress {
    description = "ssh ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description     = "http for node ingress"
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_workspacePro_application_loadbalancer.id]
    cidr_blocks     = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "sg-workspacePro-application", "created-by" = "terraform", Environment = "dev"
  }
}

resource "aws_security_group" "sg_workspacePro_backend" {
  vpc_id      = aws_vpc.workspacePro_vpc.id
  name        = "sg_workspacePro_backend"
  description = "Allow ssh and http only from public  web server"
  ingress {
    description     = "ssh ingress"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_workspacePro_application.id]
    #cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description     = "mysql ingress"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_workspacePro_application.id]
    #cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "sg-workspacePro-backend", "created-by" = "terraform", Environment = "dev"
  }
}
