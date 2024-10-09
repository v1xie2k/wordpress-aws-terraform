resource "aws_subnet" "mysubnet_1a" {
  cidr_block              = "10.0.1.0/24"
  vpc_id                  = aws_vpc.myvpc.id
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "mysubnet1a"
  }
}

resource "aws_subnet" "mysubnet_1b" {
  cidr_block              = "10.0.2.0/24"
  vpc_id                  = aws_vpc.myvpc.id
  availability_zone       = "us-west-2b"
  map_public_ip_on_launch = true
  tags = {
    Name = "mysubnet1b"
  }
}

resource "aws_subnet" "mysubnet_1c" {
  cidr_block              = "10.0.3.0/24"
  vpc_id                  = aws_vpc.myvpc.id
  availability_zone       = "us-west-2c"
  map_public_ip_on_launch = true
  tags = {
    Name = "mysubnet1c"
  }
}

resource "aws_subnet" "myprivatesubnet_1a" {
  cidr_block              = "10.0.4.0/24"
  vpc_id                  = aws_vpc.myvpc.id
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = false
  tags = {
    Name = "myprivatesubnet1a"
  }
}

resource "aws_subnet" "myprivatesubnet_1b" {
  cidr_block              = "10.0.5.0/24"
  vpc_id                  = aws_vpc.myvpc.id
  availability_zone       = "us-west-2b"
  map_public_ip_on_launch = false
  tags = {
    Name = "myprivatesubnet1b"
  }
}

resource "aws_subnet" "myprivatesubnet_1c" {
  cidr_block              = "10.0.6.0/24"
  vpc_id                  = aws_vpc.myvpc.id
  availability_zone       = "us-west-2c"
  map_public_ip_on_launch = false
  tags = {
    Name = "myprivatesubnet1c"
  }
}