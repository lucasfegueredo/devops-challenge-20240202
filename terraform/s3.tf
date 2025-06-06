resource "aws_s3_bucket" "s3" {
  bucket = "terraform-741916656380"
}

resource "aws_s3_bucket_versioning" "s3v" {
  bucket = aws_s3_bucket.s3.id
  versioning_configuration {
    status = "Enabled"
  }

  lifecycle {
    prevent_destroy = true
  }
}