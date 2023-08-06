resource "aws_subnet" "private_subnetA" {
  availability_zone = data.aws_availability_zones.azs.names[0]
  cidr_block        = "10.0.11.0/24"
  vpc_id            = aws_vpc.workspacePro_vpc.id
  tags = {
    "Name" = "private-subnetA", "created-by" = "terraform", Environment = "dev"
  }
}

resource "aws_subnet" "private_subnetB" {
  availability_zone = data.aws_availability_zones.azs.names[1]
  cidr_block        = "10.0.12.0/24"
  vpc_id            = aws_vpc.workspacePro_vpc.id
  tags = {
    "Name" = "private-subnetB", "created-by" = "terraform", Environment = "dev"
  }
}

resource "aws_subnet" "private_subnetC" {
  availability_zone = data.aws_availability_zones.azs.names[2]
  cidr_block        = "10.0.13.0/24"
  vpc_id            = aws_vpc.workspacePro_vpc.id
  tags = {
    "Name" = "private-subnetC", "created-by" = "terraform", Environment = "dev"
  }
}