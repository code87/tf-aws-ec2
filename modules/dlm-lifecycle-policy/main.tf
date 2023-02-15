
resource "aws_dlm_lifecycle_policy" "dlm_lifecycle_policy" {
  description        = "${var.name_prefix} DLM lifecycle policy"
  execution_role_arn = aws_iam_role.dlm_lifecycle_role.arn
  # TODO: move to variable
  state              = "ENABLED"

  policy_details {
    policy_type = "IMAGE_MANAGEMENT"

    # TODO: move to variable
    resource_types = ["INSTANCE"]

    schedule {
      name = "${var.name_prefix} snapshots schedule"

      create_rule {
        interval      = var.interval
        interval_unit = "HOURS"
        times         = [var.time]
      }

      retain_rule {
        count = var.snapshot_count
      }

      variable_tags = {
        instance-id = "$(instance-id)"
      }

      copy_tags = false
    }

    target_tags = {
      Name = var.target_instance_name
    }
  }

  tags = {
    Name = "${var.name_prefix}-dlm-lifecycle-policy"
  }
}

resource "aws_iam_role" "dlm_lifecycle_role" {
  name = "${var.name_prefix}-dlm-lifecycle-role"

  assume_role_policy = <<-EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
            "Service": "dlm.amazonaws.com"
          },
          "Effect": "Allow",
          "Sid": ""
        }
      ]
    }
    EOF
}

resource "aws_iam_role_policy" "dlm_lifecycle_role_policy" {
  name = "${var.name_prefix}-dlm-lifecycle-role-policy"
  role = aws_iam_role.dlm_lifecycle_role.id

  policy = <<-EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
            "Effect": "Allow",
            "Action": "ec2:CreateTags",
            "Resource": [
                "arn:aws:ec2:*::snapshot/*",
                "arn:aws:ec2:*::image/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeImages",
                "ec2:DescribeInstances",
                "ec2:DescribeImageAttribute",
                "ec2:DescribeVolumes",
                "ec2:DescribeSnapshots"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "ec2:DeleteSnapshot",
            "Resource": "arn:aws:ec2:*::snapshot/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:ResetImageAttribute",
                "ec2:DeregisterImage",
                "ec2:CreateImage",
                "ec2:CopyImage",
                "ec2:ModifyImageAttribute"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:EnableImageDeprecation",
                "ec2:DisableImageDeprecation"
            ],
            "Resource": "arn:aws:ec2:*::image/*"
        }
      ]
    }
  EOF
}
