from __future__ import annotations

from typing import Any

from checkov.terraform.checks.resource.base_resource_check import BaseResourceCheck
from checkov.common.models.enums import CheckResult, CheckCategories


class S3PCIPrivateACL(BaseResourceCheck):
    def __init__(self) -> None:
        name = "Ensure PCI Scope buckets has private ACL (enable public ACL for non-pci buckets) 4"
        id = "CKV_AWS_999"
        supported_resources = ("null_resource",)
        # CheckCategories are defined in models/enums.py
        categories = (CheckCategories.BACKUP_AND_RECOVERY,)
        guideline = "Follow the link to get more info https://docs.prismacloud.io/en/enterprise-edition/policy-reference"
        super().__init__(name=name, id=id, categories=categories, supported_resources=supported_resources, guideline=guideline)

    def scan_resource_conf(self, conf: dict[str, list[Any]]) -> CheckResult:
        return CheckResult.FAILED


check = S3PCIPrivateACL()
