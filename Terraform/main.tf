provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "my_instance" {
  ami = "ami-0f8a61b66d1accaee"
  instance_type = "t3.medium"
  key_name = "Jenkins-01-08-2026"
  tags = {
        "Name" = "Jenkins"
    }
}
resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-bucket-srikar001"

  tags = {
    Name = "Terraform State"
  }
}
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
