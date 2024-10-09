resource "aws_security_group" "mysecuritygroup" {
  name        = "wp_security_group"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.myvpc.id
  tags = {
    Name = "wp_security_group"
  }
}

resource "aws_vpc_security_group_egress_rule" "wp_allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.mysecuritygroup.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "wp_allow_http_ipv4" {
  security_group_id = aws_security_group.mysecuritygroup.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "wp_allow_ssh_ipv4" {
  security_group_id = aws_security_group.mysecuritygroup.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}