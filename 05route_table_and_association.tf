resource "aws_route_table_association" "public_route_table_associationA" {
  subnet_id      = aws_subnet.public_subnetA.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_route_table_associationB" {
  subnet_id      = aws_subnet.public_subnetB.id
  route_table_id = aws_route_table.public_route_table.id
}
resource "aws_route_table_association" "public_route_table_associationC" {
  subnet_id      = aws_subnet.public_subnetC.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_route_tableA_associationA" {
  subnet_id      = aws_subnet.private_subnetA.id
  route_table_id = aws_route_table.private_route_tableA.id
}

resource "aws_route_table_association" "private_route_tableB_associationB" {
  subnet_id      = aws_subnet.private_subnetB.id
  route_table_id = aws_route_table.private_route_tableB.id
}

resource "aws_route_table_association" "private_route_tableC_associationC" {
  subnet_id      = aws_subnet.private_subnetC.id
  route_table_id = aws_route_table.private_route_tableC.id
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.workspacePro_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway_01.id
  }
  tags = {
    "Name" = "public-route-table", "created-by" = "terraform", Environment = "dev"
  }
}
resource "aws_route_table" "private_route_tableA" {
  vpc_id = aws_vpc.workspacePro_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gatewayA.id
  }
  tags = {
    "Name" = "private-route-tableA", "created-by" = "terraform", Environment = "dev"
  }
}
resource "aws_route_table" "private_route_tableB" {
  vpc_id = aws_vpc.workspacePro_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gatewayB.id
  }
  tags = {
    "Name" = "private-route-tableB", "created-by" = "terraform", Environment = "dev"
  }
}

resource "aws_route_table" "private_route_tableC" {
  vpc_id = aws_vpc.workspacePro_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gatewayC.id
  }
  tags = {
    "Name" = "private-route-tableC", "created-by" = "terraform", Environment = "dev"
  }
}
