variable "AWS_ACCESS_KEY" {
  default = "foobar"
}
variable "AWS_SECRET_KEY" {
  default = "foobar"
}
variable "AWS_REGION" {
  default = "us-east-1"
}
variable "bucket_prefix" {
    type        = string
    description = "Creates a unique bucket name beginning with the specified prefix."
    default     = "my-s3-bucket-112233"
}