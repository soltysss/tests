package terraform

import rego.v1

deny[reason] {
    number == true

    reason := "According to this policy, undeclared variable 'number' is not equal to true"
}
