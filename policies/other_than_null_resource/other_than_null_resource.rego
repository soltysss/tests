package terraform

import input.tfplan as tfplan

# Allowed Terraform resources
allowed_resources = [
  "null_resource"
]


array_contains(arr, elem) {
  arr[_] = elem
}

deny[reason] {
    resource := tfplan.resource_changes[_]
    action := resource.change.actions[count(resource.change.actions) - 1]
    array_contains(["create", "update"], action)  # allow destroy action

    not array_contains(allowed_resources, resource.type)

    reason := sprintf(
        "%s: resource type %q is not allowed",
        [resource.address, resource.type]
    )
}
