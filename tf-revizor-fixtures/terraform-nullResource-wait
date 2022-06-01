resource "null_resource" "wait_test" {
  triggers = {
    run_id = "blabla"
  }
  provisioner "local-exec" {
    command = "sleep 30"
  }
}
