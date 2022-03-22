


# CONFIGURING git
#   --local: applies the configurations for the current repo only
#   --global: applies the configurations for the user directory
#   --system: applies the configurations for the git instalation
> git config --local user.name "First Last"
> git config --local user.email "email@address"

# remove configs
# remove a specific setting from a specific config level
> git config --global --unset user.name
# Edit a config level
> git config --global --edit
# Remove a confic section
git config --global --remove-section user

# View configuration values
> git config --list --show-origin       # shows all configs from all sources
> git config user.name                  # shows the value of user.name

# INIT a local repo
# Clone a remote repo (using ssh)
git clone git@github.com:mdfecioru/toolsdoc.git

# Initialize a new git repository
git init
# Add remote repo: git remote add <remote_name> <remote_url>
> git remote add origin git@github.com:mdfecioru/toolsdoc.git

# See the remotes
git remote -v

# Pushing a local branch on a remote
# List branches on remote
> git ls-remote
# Push the local_branch on the remote
> git push -u origin local_branch
# To fetch abranch from a remote to local repo
> git fetch origin remote_branch
# The command above will bring the remote branch locally but we do not have yet a 
# local branch that tracks the remote branch
> git checkout --track origin/remote_branch


# ADD / REMOVE / RENAME files
# Add files to staging area
> git add .                             # adds all files that are not in STAGE
> git add file1, file2                  # adds to STAGE only these 2 files
# Commit the data from staging area
> git commit -m "Comment"
# Add & Commit in a single line
> git commit -a -m "Comment"

# remove the file from both WORKING and STAGE
git rm -f filename
# remove the file from STAGE but not from WORKING (unstage the file)
git rm --cache filename

# renaming the readme.txt to readme.md - Option 1: using add
# -> In this step git sees that readme.txt is deleted and readme.md new
mv readme.txt readme.md
# -> In this step git actually discovers that the file was renamed
> git add readme.txt                    # this means copy the deletion of readme.txt from WORKING to STAGE area
> git add readme.md
# In this step COMMIT any change

# renaming the readme.txt to readme.md - Option 2: using git mv
> git mv readme.txt readme.md
# In this step COMMIT any change


# get the status of your files
> git status
> git status -s        # --> the short variant

# See the list of commits
> git log
> git log --oneline

# Diff between WORKING and STAGING areas
> git diff
# Diff between STAGING and REPOSITORY areas
# What are the changes that I have done that will go into the next commit?
> git diff --cached
> git diff --staged


# BRANCHING
# See the current branches
> git branch
> git branch -a    # lists also the remote branches

# Create a new branch
> git branch branch_name

# Switches to a branck (HEAD changes to point to the new branch) AND 
# copies data from REPOSITORY area to the WORKING and STAGING areas
> git switch branch_name
> git checkout branchname

