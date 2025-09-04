resource "aws_network_acl" "networkaclprivate" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = aws_subnet.private.*.id

  egress {
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
    protocol   = "all"
  }

  ingress {
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
    protocol   = "all"
  }

  ingress {
    rule_no    = 21
    action     = "allow"
    cidr_block = aws_vpc.main.cidr_block
    from_port  = 22
    icmp_code  = 0
    icmp_type  = 0
    protocol   = "6"
    to_port    = 22
  }

  ingress {
    rule_no    = 22
    action     = "allow"
    cidr_block = aws_vpc.main.cidr_block
    from_port  = 3389
    icmp_code  = 0
    icmp_type  = 0
    protocol   = "6"
    to_port    = 3389
  }

  ingress {
    rule_no    = 41
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    protocol   = "6"
    to_port    = 22
  }

  ingress {
    rule_no    = 42
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 3389
    protocol   = "6"
    to_port    = 3389
  }

  tags = merge(
    var.common_tags,
    {
      "Type" = "NetworkAclPrivate"
    },
    {
      "Name" = "${var.account_name}-NetworkAcl-Private"
    },
  )
}

