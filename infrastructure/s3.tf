resource "aws_s3_bucket" "hello-server-s3" {
  bucket  = var.bucket_prefix 
  tags = {
    Name        = "devops bucket"
  }
}

#acl for bucket
resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.hello-server-s3.id
  acl    = "private"
}

# Upload an object
resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.hello-server-s3.id
  key    = "file.txt"
  acl    = "private"
  source = "/workspace/devops-task-shukrunstav-gmail.com/devops/infrastructure/file.txt"
  etag = filemd5("/workspace/devops-task-shukrunstav-gmail.com/devops/infrastructure/file.txt")
}