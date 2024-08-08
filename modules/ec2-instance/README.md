# AWS EC2 Instance

Current version: `v0.0.3`

Terraform module for creating AWS EC2 instance with the following properties:
* a given instance type (e.g. t3.micro)
* launched with given IAM instance profile (optional)
* a root volume of given size
* a root volume encrypted with KMS key (optional)
* added to given subnet
* added to given security groups
* an SSH access with given key-pair
* initialized with given User Data script (optional)


## Usage

```terraform
module "my_instance" {
  source = "github.com/code87/tf-aws-ec2//modules/ec2-instance?ref=v0.0.3"

  name              = "myproject-staging-webserver"
  ami_id            = my_ami_id
  instance_type     = "t3.micro"
  ssh_key_pair      = "myproject-keypair"
  subnet_id         = my_subnet_id
  volume_size       = 16
  volume_encryption = true
  kms_key_id        = my_kms_key_arn

  iam_instance_profile = aws_iam_instance_profile.my_iam_instance_profile.name

  security_group_ids = [
    aws_security_group.my_security_group.id
  ]

  user_data = templatefile("${path.module}/user_data.sh.tftpl", {
    my_var = "value"
  })
}
```

_See also_: [examples/ec2-instance/](https://github.com/code87/tf-aws-ec2/blob/master/examples/ec2-instance/)


## Requirements

| Name        | Version           |
|-------------|-------------------|
| `terraform` | >= 1.3.0, < 2.0.0 |
| `aws`       | ~> 5.0            |


## Resources

| Name       | Type           |
|------------|----------------|
| `instance` | `aws_instance` |


## Inputs

| Name                   | Description                                                        | Type        | Default    | Required |
|------------------------|--------------------------------------------------------------------|-------------|------------|----------|
| `name`                 | EC2 Instance name. Example: `myproject-webserver`                  | `string`    |            | yes      |
| `ami_id`               | AMI ID for EC2 Instance. Varies for different regions              | `string`    |            | yes      |
| `instance_type`        | EC2 Instance type                                                  | `string`    | `t3.micro` | no       |
| `volume_size`          | Size of the volume in gibibytes (GiB)                              | `number`    | `8`        | no       |
| `volume_encryption`    | Enables or disables EC2 instance root volume encryption            | `bool`      | `false`    | no       |
| `kms_key_arn`          | KMS Custom-managed key ARN for EC2 instance root volume encryption | `string`    | `null`     | no       |
| `ssh_key_pair`         | Key-pair name for SSH access to EC2 Instance                       | `string`    |            | yes      |
| `iam_instance_profile` | EC2 Instance IAM profile name                                      | `string`    | `null`     | no       |
| `subnet_id`            | VPC Subnet ID to launch in                                         | any         |            | yes      |
| `security_group_ids`   | A list of security group IDs to associate with                     | `list(any)` |            | yes      |
| `user_data`            | User Data script to execute when launching the instance            | `string`    | `null`     | no       |


## Outputs

| Name                    | Description                             |
|-------------------------|-----------------------------------------|
| `instance_id`           | Created EC2 Instance ID                 |
| `instance_type`         | EC2 Instance type                       |
| `instance_ami_id`       | AMI ID used to created EC2 Instance     |
| `instance_ssh_key_pair` | SSH Key pair name to access             |
| `public_ip`             | Public IP address of EC2 Instance       |
| `public_dns`            | Public DNS name (a URL) of EC2 Instance |
