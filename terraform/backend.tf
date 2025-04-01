terraform {
  backend "s3" {
    bucket  = "devopschallengetfstate"   # Replace with your S3 bucket name
    key     = "terraform/state/terraform.tfstate"  # Path within the bucket
    region  = var.aws_region                 # Must match the region of your S3 bucket
    encrypt = true
  }
}
