# HTTP(s) & SSH Security Group

Current version: `v0.0.3`

Terraform module for creating EC2 Security Group in a given VPC which:
* allows HTTP (80) inbound traffic
* allows HTTPS (443) inbound traffic
* allows SSH (22) inbound traffic
* allows all outbound traffic


## Usage

```terraform
module "my_web_security_group" {
  source = "github.com/code87/tf-aws-ec2//modules/https-ssh-security-group?ref=v0.0.3"

  name_prefix = "myproject-staging"
  vpc_id      = my_vpc_id
}
```

_See also_: [examples/https-ssh-security-group/](https://github.com/code87/tf-aws-ec2/blob/master/examples/https-ssh-security-group/)


## Requirements

| Name        | Version           |
|-------------|-------------------|
| `terraform` | >= 1.3.0, < 2.0.0 |
| `aws`       | ~> 5.0            |


## Resources

| Name                        | Type                       |
|-----------------------------|----------------------------|
| `https_ssh_security_group`  | `aws_security_group` |
| `allow_http_inbound`        | `aws_security_group_rule` |
| `allow_https_inbound`       | `aws_security_group_rule` |
| `allow_ssh_inbound`         | `aws_security_group_rule` |
| `allow_all_outbound`        | `aws_security_group_rule` |


## Inputs

| Name          | Description                                                    | Type     | Default | Required |
|---------------|----------------------------------------------------------------|----------|---------|----------|
| `name_prefix` | Prefix to prepend resource names. Example: `myproject-staging` | `string` |         | yes      |
| `vpc_id`      | ID of VPC in which the Security Group must be created          | `string` |         | yes      |


## Outputs

| Name                | Description       |
|---------------------|-------------------|
| `security_group_id` | Security Group ID |
