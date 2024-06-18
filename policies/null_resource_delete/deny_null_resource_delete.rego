package terraform

import rego.v1

# Artificial delay function
delay(n) if {
    count([i | i := 1; i <= n; i + 1; re_match("^[\\w.+\\-]+@[a-zA-Z\\d\\-]+\\.[a-zA-Z\\d\\-.]+$", "blabla@test.com")]) == n
}

deny[reason] if {
  resource := input.tfplan.resource_changes[_]
  action := resource.change.actions[count(resource.change.actions) - 1]

  resource.type == "null_resource"
  action == "delete"

  # Introduce a delay loop
  delay(100000000)

  reason := sprintf(
   "Confirm the deletion of the null_resource %q",
   [resource.address],
  )
}
