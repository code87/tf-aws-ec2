output "instance_id" {
  value = aws_instance.instance.id
}

output "instance_type" {
  value = aws_instance.instance.instance_type
}

output "instance_ami_id" {
  value = aws_instance.instance.ami
}

output "instance_ssh_key_pair" {
  value = aws_instance.instance.key_name
}

output "public_ip" {
  value = aws_instance.instance.public_ip
}

output "public_dns" {
  value = aws_instance.instance.public_dns
}

