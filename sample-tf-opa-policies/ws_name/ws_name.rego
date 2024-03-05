package terraform

import input.tfrun as tfrun

variants := ["-dev", "-test", "-prod"]  # Add more variants as needed

deny["Forbidden workspace name"] {
    not any(variant in variants; endswith(tfrun.workspace.name, variant))
}
