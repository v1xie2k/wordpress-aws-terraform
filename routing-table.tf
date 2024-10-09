resource "aws_route_table" "myrt" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }
  tags = {
    Name = "myrt"
  }
}

resource "aws_route_table_association" "rt_subnet_1a" {
  subnet_id      = aws_subnet.mysubnet_1a.id
  route_table_id = aws_route_table.myrt.id
}

resource "aws_route_table_association" "rt_subnet_1b" {
  subnet_id      = aws_subnet.mysubnet_1b.id
  route_table_id = aws_route_table.myrt.id
}

resource "aws_route_table_association" "rt_subnet_1c" {
  subnet_id      = aws_subnet.mysubnet_1c.id
  route_table_id = aws_route_table.myrt.id
}