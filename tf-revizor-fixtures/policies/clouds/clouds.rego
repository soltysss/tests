package terraform

import input.tfplan as tfplan

allowed_platforms = ["aws", "azurerm", "google"]
deny_platforms = ["openstack", "vmware"]

res := tfplan.resource_changes

get_basename(path) = basename{
    arr := split(path, "/")
    basename:= arr[count(arr)-1]
}

# Check only allowed clouds
deny[msg] {
    r = res[_]
    provider_name := get_basename(r.provider_name)
    deny_platforms[_] == provider_name
    msg := sprintf("Provider %s is not allowed", [provider_name])
}
