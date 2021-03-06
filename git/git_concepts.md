
- [Git internals](#git-internals)
- [There are 3 areas used by Git](#there-are-3-areas-used-by-git)
- [MANGING CONFLICTS when merging](#manging-conflicts-when-merging)
- [Tags](#tags)
- [Remotes](#remotes)
- [References](#references)
- [ToDo](#todo)


## Git internals
- Internal git objects - kept in *.git/objects* folder
    - Blobs: file content
    - Trees: folders
    - Commits: the commits
    - Annotated Tags: metadata / label for a commit
- Branches - are kept in .git/refs/heads folder
- HEAD file contains the reference to the “active branch” (where the next commit will happen)
- A MERGE is just a *special commit* - it has 2 parents.
- Sometimes, the branches in the refs folder are packed/compressed in the *packed-refs* file
    - Use *git show-ref* command to get the branch details in this case
```
# Dispay the object content (-p is pretty print) ... use -t if you want to see object type
> git cat-file -p sha1

# Show all branches that have "main" in their name
> git show-ref main
```

## There are 3 areas used by Git
- **WORKING** area: any new files or any change goes here first
- **STAGING** area (Index): when you **add** the changes to git, these changes are placed here.
    - This is where you prepare the content of the next commit
    - Use **add** command to add changes in the staging area
- **REPOSITORY** area: this is where you actually commit the changes into git
    - It will take all the work from the staging area, create a “commit” (which will have a unique ID) and save it in git
    - Use the **commit** command


## MANGING CONFLICTS when merging
- The conflict files will have comments with the conflicts -> these need to be addressed manually
- After you handled the conflict, you need to ADD the new version of the filw to the staging area (git add ...) then you run commit again
- FAST-FORWARD: You have *branch1* and you want to merge it into *main*
    - You go on *main* and do a merge with *branch1* -> now *main* points to the result of the merge
    - Then you go on *branch1* and you want to move this branch to the same commit *main* points to
        - Just run *git merge main* from the *branch1* branch -> this will be done by simply moving (fast forwarding) the *branch1* branch to point to the same commit as *main*
- HEAD-less commit: it’s when HEAD points directly to a commit instead of a branch
    - You get in this situation if you *checkout* a commit’s sha1 instead of a branch
    - This is done to run experiments that you don't know if you want to keep around
        - If you want to give-up - just move to a branch (checkout/switch to a branch) - all the headless commits will be garbage-collected by git as they are not referenced by a branch
        - If you want to keep them - create a branch on the latest commit.
- REBASE
    - I am on *branch1* and I want to rebase with *main*
    - Git will identify the first commit common between *branch1* and *main* (*common_commit*)
    - Git will take all the commit chain between *common_commit* and *branch1* and put them on top of *main* (new commits are being created with identical content as the commits between *common_commit* and *branch1* - but the commit hashes will differ - that's why these are new commits in git objects database)
        - Conflicts may appear at this step
    - *branch1* will be pointing to the new commits on top of *main*
        - The old commits that have been rebased no longer have a branch pointing to them, thus will be garbage-collected by git
    - If you do a merge of *main* with *branch1* then this will be a simple fast-forward!
![Rebase](img/rebase.png)


## Tags
- There are 2 types of tags
    - Annotated tags: *git tag tag1 -a -m “Message”*
        - This will create a tag *tag1* (saved in *.git/refs/tags*) which will point to a new git object (type: annotated tag) which will point to the current commit object
    - Lightweight tags: *git tag tag2 -m “Message”*
        - This will create a tag *tag2* (saved in *.git/refs/tags*) which will point directly to the current commit object
- Use *git checkout* to switch to tags (*git switch* does not wok for tags)


## Remotes
- These are git repos our git repo can synchronize with
- The default remote is called *origin*
- Branches in remotes are kept in *.git/refs/remotes*
- Merging in a remote origin is done by
    - First bringing the remote data locally (git fetch)
    - Merge the local changes with the remote data that was just synced (git merge)
    - Push the final merge to remote (git push)
- PUSH - this is a command that does the fetch from a remote and the merge with the local version of the branch in a single step
- FETCH - it downloads (fetches) the commit objects from a remote (but does not yet merges them on the local branch)
- PULL - this is a FETCH followed by a MERGE (in local branch or with a branch from another repository)
    - By default the "merging strategy" is *merge*: changes from remote are merged with the unbublished changes (from local branch) and a new commit object is created
    - "--rebase" this changes the "merge strategy" to *rebase*: the unpublished changes are reaplied on the published changes and no new commit will be added to the history.
![Fetcg / Pull](img/fetch_pull.png)


## References
- [How to Write a Git Commit Message](https://cbea.ms/git-commit/)
- [Visualizing git](https://git-school.github.io/visualizing-git)

## ToDo
- git pull --rebase
- clone --bare
  - A repository that does not have a working copy
  - In this case, the root folder os the content of the .git
- git commit --amend
- git bisect
