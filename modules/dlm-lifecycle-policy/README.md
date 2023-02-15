# AWS DLM Lifecycle Policy

Terraform module for creating AWS Data Lifecycle Manager (DLM) Lifecycle Policy for EC2 instance backup.


## Usage

```terraform
module "my_dlm_lifecycle_policy" {
  source = "github.com/code87/tf-aws-ec2//modules/dlm-lifecycle-policy?ref=v0.0.1"

  name_prefix          = "myproject-staging"
  target_instance_name = "myproject-webserver"
  interval             = 24
  time                 = "03:30"
  snapshot_count       = 7
}
```


## Requirements

| Name        | Version           |
|-------------|-------------------|
| `terraform` | >= 1.0.0, < 2.0.0 |
| `aws`       | ~> 4.0            |


## Resources

| Name                        | Type                       |
|-----------------------------|----------------------------|
| `dlm_lifecycle_policy`      | `aws_dlm_lifecycle_policy` |
| `dlm_lifecycle_role`        | `aws_iam_role`             |
| `dlm_lifecycle_role_policy` | `aws_iam_role_policy`      |


## Inputs

| Name                   | Description                                                                                            | Type     | Default | Required |
|------------------------|--------------------------------------------------------------------------------------------------------|----------|---------|----------|
| `name_prefix`          | Prefix to prepend resource names. Example: `myproject-staging`                                         | `string` |         | yes      |
| `target_instance_name` | Name of EC2 Instance to backup. Example: `myproject-webserver`                                         | `string` |         | yes      |
| `interval`             | How often lifecycle policy should be evaluated. Values: 1, 2, 4, 6, 8, 12, 24                          | `number` | `24`    | no       |
| `time`                 | Time in 24 hour clock format that sets when the lifecycle policy should be evaluated. Example: `03:30` | `string` |         | yes      |
| `snapshot_count`       | How many snapshots to keep. Must be an integer between 1 and 1000                                      | `number` | `1`     | no       |


## Outputs

| Name                       | Description              |
|----------------------------|--------------------------|
| `dlm_lifecycle_policy_arn` | DLM Lifecycle Policy ARN |
| `dlm_lifecycle_policy_id`  | DLM Lifecycle Policy ID  |
