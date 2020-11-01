package terraform

import input.tfplan as tfplan

allowed_platforms = ["aws", "azurerm", "google"]


allowed_instance_types = {
    "aws": ["t1.micro", "t1.small", "t2.nano", "t2.small"],
    "google": ["f1-micro", "n1-standard-1", "n1-standard-2"],
    "azurerm": ["Basic_A0", "Basic_A1", "Basic_A2", "Standard_D1_v2", "Standard_DS1_v2", "Standard_DS2_v2"]
}

res := tfplan.resource_changes



contains(arr, elem) {
  arr[_] = elem
}

get_basename(path) = basename{
    arr := split(path, "/")
    basename:= arr[count(arr)-1]
}

resources := [r | r = res[_]; allowed_platforms[_] == get_basename(r.provider_name)]

# Check instance types

#Azure
deny[msg] {
    r = res[_]
    provider_name := get_basename(r.provider_name)
    provider_name == "azurerm"
    instance_types = allowed_instance_types[provider_name]
    not contains(instance_types, r.change.after.vm_size)
    msg := sprintf("Instance type '%s' is not allowed on cloud '%s'",
                    [r.change.after.vm_size, provider_name])
}

#EC2
deny[msg] {
    r = res[_]
    provider_name := get_basename(r.provider_name)
    provider_name == "aws"
    instance_types = allowed_instance_types[provider_name]
    not contains(instance_types, r.change.after.instance_type)
    msg := sprintf("Instance type '%s' is not allowed on cloud '%s'",
                    [r.change.after.instance_type, provider_name])
}

#GCE
deny[msg] {
    r = res[_]
    provider_name := get_basename(r.provider_name)
    provider_name == "google"
    instance_types = allowed_instance_types[provider_name]
    not contains(instance_types, r.change.after.machine_type)
    msg := sprintf("Instance type '%s' is not allowed on cloud '%s'",
                    [r.change.after.machine_type, provider_name])
}
