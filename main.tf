provider "aws" {
    region = "${var.aws_region}"
}

resource "aws_s3_bucket" "sssftp_account_test_bucket" {
    bucket = "sssftp_account_test_bucket"
    acl = "private"

    tags {
        Name = "Account-Test Bucket"
    }
}
