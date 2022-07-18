###### AWS PROVIDERS #######
############################

provider "aws" {
  region     = "us-east-2"
  access_key = "AKIA2ADFQRK4QGKBOVYA"
  secret_key = "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"
}



###### S3 bucket creation #######
#################################
resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}
resource "aws_s3_bucket" "cc" {
  bucket = "conformance-pack1234"
  #aws_s3_bucket_acl = "public"
  tags = {
    Name        = "My bucket"
    Environment = "test"
  }
}
resource "aws_s3_bucket_public_access_block" "s3Public" {
bucket = aws_s3_bucket.cc.id
block_public_acls = true
block_public_policy = true
ignore_public_acls = true
restrict_public_buckets = true
}
resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.cc.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}
resource "aws_s3_bucket_acl" "bucket" {
  bucket = aws_s3_bucket.cc.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.cc.id
  versioning_configuration {
    status = "Enabled"
  }
}

#########   object creation   ########
####################################


resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.cc.id
  key    = "ec2ands3.yaml"
  source = "ec2ands3.yaml"
  etag = filemd5("ec2ands3.yaml")
}

####### config recoder enable #######
#####################################

/*resource "aws_config_configuration_recorder_status" "foo" {
 # name       = aws_config_configuration_recorder.foo.name
  is_enabled = true
  depends_on = [aws_config_delivery_channel.foo]
}

resource "aws_iam_role_policy_attachment" "a" {
  role       = aws_iam_role.r.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRole"
}



resource "aws_config_delivery_channel" "foo" {
  name           = "example"
  s3_bucket_name = aws_s3_bucket.bb.bucket
}

#resource "aws_config_configuration_recorder" "foo" {
#  name     = "example"
#  role_arn = aws_iam_role.r.arn
#}

resource "aws_iam_role" "r" {
  name = "example-awsconfig"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "config.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy" "p" {
  name = "awsconfig-example"
  role = aws_iam_role.r.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.bb.arn}",
        "${aws_s3_bucket.bb.arn}/*"
      ]
    }
  ]
}
POLICY
}*/


########### conformance pack creation ###############
#####################################################


resource "aws_config_conformance_pack" "example" {
  name            = "AwsConfigConformance"
  template_s3_uri = "s3://${aws_s3_bucket.cc.bucket}/${aws_s3_bucket_object.object.key}"

  #depends_on = [aws_config_configuration_recorder_status.foo]
}

