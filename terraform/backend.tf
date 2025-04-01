terraform {
  backend "s3" {
    bucket  = "devopschallengetfstate"   # Replace with your S3 bucket name
    key     = "terraform/state/terraform.tfstate"  # Path within the bucket
    region  = "us-east-1"                 # Must match the region of your S3 bucket
    encrypt = true
  }
}
