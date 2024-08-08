resource "aws_instance" "instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.ssh_key_pair
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  iam_instance_profile   = var.iam_instance_profile
  user_data              = var.user_data

  root_block_device {
    volume_size = var.volume_size
    encrypted   = var.volume_encryption
    kms_key_id  = var.kms_key_arn
  }

  tags = {
    Name = var.name
  }

  lifecycle {
    create_before_destroy = true
  }
}
