#!/bin/bash

# Acknowledgement: https://dev.to/forcetrekker/single-shell-script-command-to-stage-all-files-commit-and-push-to-current-branch-3d0h
#
# Alias this script in ~/.bashrc or ~/.zshrc with:
#     alias pushit='sh "path/to/this/script.sh"'
#
# Usage:
#     pushit <remote_repo> <remote_branch> <commit_message>
#
# Default:
#     pushit "stash" "stash" current-date-time
#
# Note: if using <remote_branch> = "current", git will pull the current branch
#

# get arguments
remote_repo="$1"
remote_branch="$2"
commit_message="$3"

current_branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
current_date=$(date '+%Y-%m-%d %H:%M:%S')

# If no backup remote repo is passed, use "stash"
if [[ -z "${remote_repo// }" ]]; then
    remote_repo="stash"
fi

# If no remote branch is passed, use "stash"
if [[ -z "${remote_branch// }" ]]; then
    remote_branch="stash"
elif [[ "$remote_branch" == "current" ]]; then
    remote_branch=$current_branch
fi

# If no commit message is passed, use current date time in the commit message
if [[ -z "${commit_message// }" ]]; then
    commit_message=$current_date
fi

# # git pull
# if [[ "$remote_branch" == "master" ]]; then
#     git pull "$remote_repo" "$remote_branch"
# else
#     git pull "$remote_repo" "$remote_branch"
# fi
# echo "==== Pull changes from '$remote_repo' repo - '$remote_branch' branch"

# stage all changes
echo ""
echo "================================================================="
echo "+ Staging all tracked files to '$remote_repo' repo - '$remote_branch' branch"
echo "-----------------------------------------------------------------"
git add -A

# add commit
echo ""
echo "================================================================="
echo "+ Adding the commit with message: '$commit_message'"
echo "-----------------------------------------------------------------"
git commit -m "$commit_message"

# git push
echo ""
echo "================================================================="
echo "+ Pushing changes to '$remote_repo' repo - '$remote_branch' branch"
echo "-----------------------------------------------------------------"
if [[ "$remote_branch" == "master" ]]; then
    git push "$remote_repo" "$remote_branch"
else
    git push "$remote_repo" "$remote_branch"
    # git push "$remote_repo" "$remote_repo/$remote_branch"
fi
