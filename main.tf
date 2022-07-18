resource "aws_s3_bucket" "mys3" {
  bucket = "kiranbucket25-02-22"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
