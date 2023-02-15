resource "aws_security_group" "https_ssh_security_group" {
  name        = "${var.name_prefix}-https-ssh-sg"
  description = "EC2 Security Group with HTTP, HTTPS and SSH access"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.name_prefix}-https-ssh-sg"
  }
}

resource "aws_security_group_rule" "allow_http_inbound" {
  type              = "ingress"
  description       = "Allow inbound traffic to HTTP port"
  security_group_id = aws_security_group.https_ssh_security_group.id

  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_https_inbound" {
  type              = "ingress"
  description       = "Allow inbound traffic to HTTPS port"
  security_group_id = aws_security_group.https_ssh_security_group.id

  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_ssh_inbound" {
  type              = "ingress"
  description       = "Allow inbound traffic to SSH port"
  security_group_id = aws_security_group.https_ssh_security_group.id

  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_all_outbound" {
  type              = "egress"
  description       = "Allow all outbound traffic"
  security_group_id = aws_security_group.https_ssh_security_group.id

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
