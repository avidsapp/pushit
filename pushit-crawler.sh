#!/bin/bash

# Alias this script in ~/.bashrc or ~/.zshrc with:
#     alias pushit-crawler='sh "path/to/this/script.sh"'
#
# Usage:
#     pushit-crawler <project_root> <repo_dir> <automation_dir> <automation_script>
#
# Default:
#     pushit-crawler "/home/$USER/dev" "repos" "auto" "pushit.sh"

# get the argument
project_root="$1"
repo_dir="$2"
automation_dir="$3"
automation_script="$4"

# If no project root directory is provided, use "~/dev"
if [[ -z "${project_root// }" ]]; then
    project_root="/home/$USER/dev"
fi

# If no repo directory is provided, use "repos"
if [[ -z "${repo_dir// }" ]]; then
    repo_dir="repos"
fi

# If no automation directory is provided, use "auto"
if [[ -z "${automation_dir// }" ]]; then
    automation_dir="auto"
fi

# If no automation script is provided, use "pushit.sh"
if [[ -z "${automation_script// }" ]]; then
    automation_script="pushit.sh"
fi

# Traverse through each directory in $root_dir and run the script
cd "$project_root/$repo_dir"
for d in `ls -d */*/`; do
    cd "$project_root/$repo_dir/$d"
    echo ""
    echo ""
    echo ""
    echo ""
    echo "  PWD: $PWD             "
    echo ""
    . "$project_root/$automation_dir/$automation_script"
done

# Push overall git repo (Dev Env) to origin master
cd "$project_root"
. "$project_root/$automation_dir/$automation_script" origin master

echo ""
echo ""
echo "      --------------------------      "
echo "      |                        |      "
echo "      |    PUSHIT COMPLETED    |      "
echo "      |                        |      "
echo "      --------------------------      "
echo ""
echo ""
echo ""
echo " 👋 BuhBye Now 👋"
echo ""

exit
