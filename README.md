# pushit

![Push It Real Good](https://tenor.com/bf3FA.gif)

#### ***Push It Real Good***
Keep your localhost codebases up-to-date (and backed-up) across devices with daily automated pushes. Or use as an auto-pushing tool.


## Requirements
- git


## Model File Tree
```
|
└─── dev/                             (this is a cloned/linked git repo)
    |
    │   README.md
    │   .gitignore    
    │
    └─── auto/
    │   │   pushit-crawler.sh
    │   │   pushit.sh
    |   |   README.md
    |
    └─── .../
    |       └─── ...
    |       | ...
    |
    └─── repos/                       (directory crawled for git pushes)
    |       └─── client/
    |       │      └─── project-1/    (this is a cloned/linked git repo)
    |       │      |     └─── .git/
    |       |      |     |   .gitignore
    |       │      |     |   project-files.txt
    |       │      |     |   ...
    |       │      |     
    |       │      └─── project-2/    (this is a cloned/linked git repo)
    |       │      |     └─── .git/
    |       |      |     |   .gitignore
    |       │      |     |   project-files.txt
    |       │      |     |   ...
    |       │      |     
    |       |      | ...
    |       |      
    |       └─── internal/
    |       │      └─── project-1/    (this is a cloned/linked git repo)
    |       │      |     └─── .git/
    |       |      |     |   .gitignore
    |       │      |     |   project-files.txt
    |       │      |     |   ...
    |       │      |     
    |       │      └─── project-2/    (this is a cloned/linked git repo)
    |       │      |     └─── .git/
    |       |      |     |   .gitignore
    |       │      |     |   project-files.txt
    |       │      |     |   ...
    |       │      |     
    |       |      └─── ...
    |       |
    |       └─── ...
    |
    └─── tools/
    |       └─── ...
    |
    └─── ...

```


- Note: this setup is based on this file structure located at the user home directory. In order to modify, change:
    - `repos/`
    - `auto/`
    - script names and defined variables
    - project root location - default: `/home/$USER/dev`


## Setup
- Clone repo into developer environment ("monorepo") project root folder:
    - `git clone https://github.com/username/reponame.git`
    - `git remote add stash https://url.com/user/repo.git` - Where your daily stashes for each repo are pushed
        - Some git services require the username in the URL - `git remote add stash https://url-with-username.com/user/repo.git`
    - `git checkout -b stash` - What branch your daily stashes for each repo are pushed to
- Create repo directory:
    - `mkdir repos && cd repos`
- Git clone repos into their respective directories in `repos/`
- Ensure directories are gitignored at the monorepo root level
- Ensure scripts are executable:
    ```
      chmod +x ~/path/to/scripts/pushit.sh
      chmod +x ~/path/to/scripts/pushit-crawler.sh
    ```
- Ensure `~/.bashrc` or `~/.zshrc` have the appropriate aliases:
    ```
      # aliases for git-push automation scripts
      alias pushit="~/path/to/pushit.sh"
      alias pushit-crawler="~/path/to/pushit-crawler.sh"
    ```
- Add your `pushit-crawler.sh` script to cron jobs - `crontab -e`:
    ```
      # structure - 1 2 3 4 5 /path/to/command arg1 arg2
      0 8 * * * ~/path/to/pushit-crawler.sh
    ```
    - This cron job will run the `pushit-crawler` script everyday at 8am
- Setup git credentials on localhost:
    - `git config --global user.name "username"`
    - `git config --global user.email email@email.com`
- Add git public key to platforms:
    - Bitbucket
    - Gitlab
    - Github
- Cache your git credentials so the script can push to repos behind firewalls:
    - [Bitbucket](https://confluence.atlassian.com/bitbucketserver/permanently-authenticating-with-git-repositories-776639846.html)
    - Gitlab
    - Github
- Setup environment variables so the script can push to repos behind firewalls:
    - `sudo cp .env.example .env && sudo nano .env`


## Usage
#### Change arguments in <brackets>:
- `pushit-crawler <optional:project_root> <optional:repo_dir> <optional:automation_dir> <optional:automation_script>`:
    - From anywhere on the cmd line - `path/to/pushit-crawler.sh` or `pushit-crawler`
- `pushit <optional:remote_repo> <optional:remote_branch> <optional:commit_message>`:
    - Pushing to designated remote branches from the current director - `path/to/pushit-crawler.sh <remote_repo> <remote_branch> <commit_message>` or `pushit <remote_repo> <remote_branch> <commit_message>`
