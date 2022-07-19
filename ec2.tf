provider "aws" {
  region     = "us-east-2"
}

resource "aws_s3_bucket" "bb" {
 # bucket = "conformance-pack-aws"
  #aws_s3_bucket_acl = "public"
  tags = {
    Name        = "My bucket"
    Environment = "test"
  }
}
