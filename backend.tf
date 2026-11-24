terraform {
  backend "s3" {
    bucket = "tf-test-af-tfstatefiles"
    key    = "terraform.tfstate"
    region = "sa-east-1"
    #profile                = "test-af"
  }
}
