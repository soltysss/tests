package terraform

import rego.v1

# Artificial delay function with nested loops and computationally intensive operations
delay(n) = true if {
    sum := 0
    count([i | i := 1; i <= n; i + 1; sum := sum + heavy_computation(i)]) == n
}

# Function to perform heavy computation
heavy_computation(i) = result if {
    # Nested loop for additional complexity
    total := 0
    count([j | j := 1; j <= 1000; j + 1; total := total + i * j]) == 1000
    result = total
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
