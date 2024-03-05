package terraform

import input.tfrun as tfrun

deny["Forbidden workspace name"] {
    count({variant | set["-dev", "-test", "-prod"]; endswith(tfrun.workspace.name, variant)}) == 0
}
