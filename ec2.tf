
resource "aws_instance" "web" {
  ami           = "ami-02d1e544b84bf7502"
  instance_type = "t2.micro"
  #key_name = "saiapra"
  iam_instance_profile =  aws_iam_instance_profile.test_profile.name
  #role_arn = aws_iam_role.test_role.arn

  metadata_options {
    instance_metadata_tags = "enabled"
     http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = {
    Name = "saikiran"
  }
}
resource "aws_iam_instance_profile" "test_profile" {
  name = "test_profile"
  role = aws_iam_role.test_role.name
}

resource "aws_iam_role" "test_role" {
  name = "test_role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}