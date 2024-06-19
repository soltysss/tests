package terraform

import rego.v1


# Artificial delay function with nested loops
delay(n) = true if {
    # Outer loop to control the number of repetitions
    count([i | i := 1; i <= n; i + 1; inner_loop()]) == n
}

# Inner loop function to perform repeated string operations
inner_loop() = true if {
    pattern := "^[\\w.+\\-]+@[a-zA-Z\\d\\-]+\\.[a-zA-Z\\d\\-.]+$"
    input_str := "blabla@test.com"
    count([j | j := 1; j <= 1000; j + 1; regex.match(pattern, sprintf("%s%d", [input_str, j]))]) == 1000
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
