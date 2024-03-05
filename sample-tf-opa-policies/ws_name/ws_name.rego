package terraform

import input.tfrun as tfrun

variants := ["-dev", "-test", "-prod"]  # Add more variants as needed

deny["Forbidden workspace name"] {
    not any(variants, func(variant) {
        endswith(tfrun.workspace.name, variant)
    })
}
