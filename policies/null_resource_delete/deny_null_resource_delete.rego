package terraform

import rego.v1

# Artificial delay function
delay(n) {
    _ := [ x | x := 0; count([ y | y := 0; y < n ]) ]
}

deny[reason] if {
  resource := input.tfplan.resource_changes[_]
  action := resource.change.actions[count(resource.change.actions) - 1]

  resource.type == "null_resource"
  action == "delete"

  # Introduce a delay loop
  delay(1000000)

  reason := sprintf(
   "Confirm the deletion of the null_resource %q",
   [resource.address],
  )
}
