


# CONFIGURING git
#   --local: applies the configurations for the current repo only
#   --global: applies the configurations for the user directory
#   --system: applies the configurations for the git instalation
git config --local user.name "First Last"
git config --local user.email "email@address"

# remove configs
# remove a specific setting from a specific config level
git config --global --unset user.name
# Edit a config level
git config --global --edit
# Remove a confic section
git config --global --remove-section user

# View configuration values
git config --list --show-origin       # shows all configs from all sources
git config user.name                  # shows the value of user.name

# INIT a local repo
# Clone a remote repo (using ssh)
git clone git@github.com:mdfecioru/toolsdoc.git

# Initialize a new git repository
git init
# Add remote repo: git remote add <remote_name> <remote_url>
git remote add origin git@github.com:mdfecioru/toolsdoc.git

# See the remotes
git remote -v
git remote -v show origin

# Pushing a local branch on a remote
# List branches on remote
git ls-remote
# Push the local_branch on the remote (see below for a more generic use-case)
git push origin local_branch
# If the local_branch does not have a corespondent branch on the remote side, 
# then use "-u" to create the branch on the remote.
git push -u origin local_branch
# pushing to HEAD is equivalent to pushing to a remote branch having 
# the same name as your current branch (HEAD == curent branch)
git push -u origin HEAD
# See the tracking branches - links to remote branches
git branch -vv
# To fetch a branch from a remote to local repo
git fetch origin remote_branch
# The command above will bring the remote branch locally but we do not have yet a 
# local branch that tracks the remote branch
git checkout --track origin/remote_branch
# If I have a local_branch in my local repo and a remote_branch on the remote
#   and I want to set the remote_branch as the tracking branch for the local_branch
#     - NOTE: the local_branch and the remote_branch do not have to have the same name!
git checkout -b local_branch            # first switch to local_branch
git branch -u origin/remote_branch      # set remote_branch as tracking branch

# Generic PUSH: if you have the local_branch in the local repo and you want to push data
#   to remote_branch on the remote (the local_branch and the remote_branch
#   do not have to have the same name)
# Step 1 - run pull to get the latest updates from the remote branch
git pull
# Step 2 - switch to local_branch
git checkout local_branch
# Step 3 - merge local_branch with the latest version of remote_branch that was just pulled from remote
git merge origin/feature
# Step 4 - push the result of the merge from the local local_branch to the remote remote_branch
#   - NOTE: replace "origin" with whatever remote repo you want to push to
git push origin local_branch:remote_branch


# ADD / REMOVE / RENAME files
# Add files to staging area
git add .                             # adds all files that are not in STAGE
git add file1, file2                  # adds to STAGE only these 2 files
# Commit the data from staging area
git commit -m "Comment"
# Add & Commit in a single line
git commit -a -m "Comment"

# remove the file from both WORKING and STAGE
git rm -f filename
# remove the file from STAGE but not from WORKING (unstage the file)
git rm --cache filename

# renaming the readme.txt to readme.md - Option 1: using add
# -> In this step git sees that readme.txt is deleted and readme.md new
mv readme.txt readme.md
# -> In this step git actually discovers that the file was renamed
git add readme.txt                    # this means copy the deletion of readme.txt from WORKING to STAGE area
git add readme.md
# In this step COMMIT any change

# renaming the readme.txt to readme.md - Option 2: using git mv
git mv readme.txt readme.md
# In this step COMMIT any change


# get the status of your files
git status
git status -s        # --> the short variant

# See the list of commits
git log
git log --oneline
# Show only the last 3 commits
git log -3
# show detailed view of commits - the files in each commit
git log --stat
# an even detailed view of commits - the changes in each commit
git log --patch


# Diff between WORKING and STAGING areas
git diff
# Diff between STAGING and REPOSITORY areas
# What are the changes that I have done that will go into the next commit?
git diff --cached
git diff --staged


# BRANCHING
# See the current branches
git branch
git branch -a    # lists also the remote branches

# Create a new branch
git branch branch_name

# Switches to a branck (HEAD changes to point to the new branch) AND 
# copies data from REPOSITORY area to the WORKING and STAGING areas
git switch branch_name
git checkout branchname
# If the branch does not exist, use "-b"
git checkout -b branchname
# If you don't specify a starting point, the new branch will be created to point to current commit
# You can also specify the starting point
#  -> in the case below the new branch will point to the last commit from "origin/master"
git checkout -b branchname origin/master

# MERGING branches
# If we are on "master" branch and we want to merge the work from "new_branch"
#  - a new commit will be created that will point to both commits that were merged
git merge new_branch


# Resetting commits - don't do this if the commit was already pushed to remote!
#   - NOTE: all the commits from the selected commitHashID will be reset (from all branches!!!)
# Reset the commit from repo to the STAGE area
git reset --soft commitHashID
# Reset the commit from repo to the WORKING area (default mode)
git reset --mixed commitHashID
# Reset the commit from repo to trash (you no longer need this data)
git reset --hard commitHashID


# Stashing the work
# Push all the data from STAGING area into stash. STAGE will be emptied out.
git stash
# List the data that was stashed away
git stash list
# A more detailed view on what was stashed away  
git stash show
# Extract the latest stashed data from stash to STAGING area
git stash pop
