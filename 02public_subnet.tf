resource "aws_subnet" "public_subnetA" {
  availability_zone = data.aws_availability_zones.azs.names[0]
  cidr_block        = "10.0.1.0/24"
  vpc_id            = aws_vpc.workspacePro_vpc.id
  tags = {
    "Name" = "public-subnetA", "created-by" = "terraform", Environment = "dev"
  }
}

resource "aws_subnet" "public_subnetB" {
  availability_zone = data.aws_availability_zones.azs.names[1]
  cidr_block        = "10.0.2.0/24"
  vpc_id            = aws_vpc.workspacePro_vpc.id
  tags = {
    "Name" = "public-subnetB", "created-by" = "terraform", Environment = "dev"
  }
}

resource "aws_subnet" "public_subnetC" {
  availability_zone = data.aws_availability_zones.azs.names[2]
  cidr_block        = "10.0.3.0/24"
  vpc_id            = aws_vpc.workspacePro_vpc.id
  tags = {
    "Name" = "public-subnetC", "created-by" = "terraform", Environment = "dev"
  }
}