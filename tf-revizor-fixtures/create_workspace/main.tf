
terraform {
    required_providers {
        scalr = {
            source = "registry.scalr.io/scalr/scalr"
            version= "2.1.0"
        }
    }
}

data "scalr_environment" "test" {
  name = "tfenv2" 
}

data "scalr_vcs_provider" "example" {
  name = "sts"
}

resource "scalr_workspace" "me" {
  name = "test"
  environment_id = data.scalr_environment.test.id
  vcs_repo {
    identifier = "soltysss/tests"
    branch = "main"
  }
  working_directory = "tf-revizor-fixtures/local_wait"
  vcs_provider_id = data.scalr_vcs_provider.example.id
}

