
resource "null_resource" "wait" {
  triggers = {
      run_id = "Bla"
      name   = "bla"
  }
  provisioner "local-exec" {
    command = "sleep 1"
     environment = {
       FOO = "bar"
       BAR = 1
       BAZ = "true"
     }
  }
}

module "assertion_unix_only" {
  source  = "Invicton-Labs/assertion/null"

  // The condition to ensure is TRUE
  // In this example, assert that the operating system uses forward slashes for path separators
  condition = "/" == "/"

  // The error message to print out if the condition evaluates to FALSE
  error_message = "This Terraform configuration can only be run on Unix-based machines."
}
