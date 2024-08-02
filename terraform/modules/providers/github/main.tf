
  terraform {
    required_providers {
       github = {
       source  = "integrations/github"
       version = "~> 6.0"
     }
   
   }
  }
  variable "github_token"{
    type        = string
    sensitive = true

  }
provider "github" {
    token = var.github_token
    
  }
