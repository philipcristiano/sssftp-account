provider "aws" {
    region = "${var.aws_region}"
}

resource "aws_s3_bucket" "sssftp_account_test_bucket" {
    bucket = "${var.sssftp_bucket}"
    acl = "private"

    tags {
        Name = "Account-Test Bucket"
    }
}

resource "aws_iam_role" "sssftp_role" {
    name = "sssftp_role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "AWS": "${var.sssftp_account_number}"
      },
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "${var.sssftp_external_id}"
        }
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "sssftp_s3_policy" {
    name = "sssftp_s3_policy"
    role = "${aws_iam_role.sssftp_role.id}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::${var.sssftp_bucket}",
        "arn:aws:s3:::${var.sssftp_bucket}/*"
      ]
    }
  ]
}
EOF
}
