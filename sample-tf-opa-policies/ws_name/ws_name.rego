package terraform

import input.tfrun as tfrun

forbidden_strings := ["-dev", "-test", "-prod"]  # Add more strings as needed

deny["Forbidden workspace name"] {
    string := forbidden_strings[_]
    endswith(tfrun.workspace.name, string)
}
