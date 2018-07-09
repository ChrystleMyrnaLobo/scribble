# Getting started with Git Version Control *(Assuming you have a GitHub account)*
Disclaimer: This is not exhaustive, only for hitchhiking
### Setup git
1. Download git
`sudo get-apt install git`
2. Setup Git Proxy (if required)
`git config --global http.proxy http://proxyuser:proxypwd@proxy.server.com:8080`
3. Set your Git username for every repository on your computer
`git config --global user.name "Your name"`
4. Set your Git email for every repository on your computer
`git config --global user.email "github-account@gmail.com"`

## Case #1 Remote to Local i.e. Get a GitHub Repo to your local sytem
If you want to get a copy of an existing Git repository — for example, a project you’d like to contribute to.
1. Open a terminal and go to folder where you want to download the repo
`cd /path/to/folder`
2. Go to the repo on GitHub and get the URL 
'Clone or Download > Clone with HTTPS'
Copy the URL (It will be something like https://github.com/path/to/repo')
3. Clone a repo from GitHub using the URL
`git clone https://github.com/path/to/repo`
This creates a new subdirectory which has the repo

## Case #2 Local to Remote i.e. Sync repo on your local with GitHub
If you have a project directory that is currently not under version control and you want to start controlling it with Git
1. Open a terminal and go to folder 
`cd /path/to/folder`
2. Initialize a git repo locally
`git init`
This creates a new subdirectory named .git that contains all of your necessary repository files.
3. Go to the repo on GitHub and get the URL. (Create a new repo, if you haven't done it)
'Clone or Download > Clone with HTTPS'
Copy the URL (It will be something like https://github.com/path/to/repo')
3. Setup remote which is where your local repo will be pushed and fetched
`git remote add origin https://github.com/path/to/repo`
4. Check the remote
`git remote -v`

## Working with the local repo
To discard all local changes. `git reset --hard origin/master`.
**OR**
1. After making changes, Add the files in your local repository. This stages them for the commit.
`git add .`
This adds **all** files to be tracked
2. Now commit the files on the staging area. *As a convention, commit after making meaniful changes (like fixed bug, added feature), even if it is a one code line change*
`git commit -m "Initial Commit"`
3. Push all changes
`git push origin master`
4. Pull latest 
`git pull origin master`

### Merge Conflict (Please read)
- https://www.git-tower.com/learn/git/ebook/en/command-line/advanced-topics/merge-conflicts

### References:
- https://git-scm.com/book/en/v2/Git-Basics-Getting-a-Git-Repository
- https://help.github.com/articles/adding-an-existing-project-to-github-using-the-command-line/
- https://github.com/desktop/desktop/issues/2789
- https://help.github.com/articles/setting-your-username-in-git/
