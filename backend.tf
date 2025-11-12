terraform{
    backend "s3"{
        bucket                  = "tf-test-tfstatefiles"
        key                     = "terraform.tfstate"
        region                  = "sa-east-1"
        shared_credentials_file = "$HOME/.aws/credentials"
        #profile                 = "test"
    }
}
