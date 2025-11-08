terraform {
  backend "s3" {
    bucket         = "sabeh-s3-bucket"
    key            = "sabeh-statefile"
    region         = "us-east-1"
    encrypt        = true
  }
}
