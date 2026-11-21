
# Topics
Git fundamentals and commits
Branches and remote synchronization
Pull requests and reviews
Branch protection concepts
Merge conflict resolution

# Command	Purpose
git init	[Create a local Git repository, The .git directory contains Git's repository metadata and history, including commit objects, references, and configuration.]
git status	[See changed/untracked files]
git add	[Stage changes for a commit]
git commit	[Record a version]
git log OR git log --oneline	[View commit history]
git log --oneline --graph --all --decorate -8
git diff [shows unstaged changes relative to the staging area.]
git diff --staged	[Shows difference in staged area ONLY. ]

| Command                      | Purpose                        |
|------------------------------|---------------------------------------------|
| bash -n health.sh            | Validate Bash syntax                        |
| shellcheck health.sh         | Perform static analysis                     |
| echo $?                      | Display previous command's exit code        |
| git status -sb               | Show current branch and status              |
| git switch master            | Switch to main development branch           |
| git pull --ff-only           | Synchronize without creating a merge commit |
| git log --oneline --graph -5 | Inspect recent Git history                  |
|                              |                                             |

Working directory: Where you edit health.sh.
Staging area: The exact file content selected for the next commit.
Local repository: Where committed versions are recorded.

Working directory > staging Area > Local repository

git init
git clone
git add
git commit
git push
git pull
git branch
git checkout
git merge
git revert
git reset

# Git Recovery and Undoing Mistakes
Working directory < Staging Area < committed history

Situation									Recommended command
Modified a file but haven't staged it		git restore health.sh [git restore health.sh discards unstaged modifications to that file. In production, always inspect git diff before running it.]
Staged an unwanted change					git restore --staged health.sh
Need to undo an already committed change	git revert <commit-id> [This creates a new commit that reverses the previous commit, while preserving the original commit in history.]


# What is a Git branch?
Imagine you maintain health.sh for production servers. You want to add nginx monitoring, but the existing script must remain unchanged until the feature is tested.

Key concept: Git branches let you work on different versions of the same project without creating multiple copies of the project directory.

git branch
git switch -c feature/nginx-check [Create and switch to a branch:]
git switch master [switch to branch master]
git merge feature/nginx-check [merge the additional branch from master branch]
git branch -d feature/nginx-check [Delete the branch once branch is merged and not needed anymore]


# Resovled branch conflict [practical exercise]
Engineers made changes on the same line of 2 different branches and commit is done. 
Now merging file from Master creating conflict, 
Engineers have to be agreed on a solution

Q — How to resolve a merge conflict
The developer must examine both changes, decide on the correct value with the team, and edit the file to remove the conflict markers.
Important: Never choose a conflict resolution solely because one side is newer. The correct choice depends on application requirements.

# GitHub and Remote Repositories: 

## Git vs GitHub
Git	: GitHub
Version control software	Online platform hosting Git repositories
Runs on your Ubuntu VM	Hosted service
Tracks commits and branches	Stores shared repositories and supports collaboration
Can work without internet	Requires network access for online operations

Recommended habit for production-related repositories: Fetch, inspect the changes, then integrate them deliberately.

## Essential commands:
Command	What it does
git remote -v	[Displays configured remote repository URLs]
git remote add origin URL	[Adds a remote named origin]
git push	[Sends local commits to a remote] [push — upload your local commits and branch.-u — set the upstream tracking relationship. origin — destination remote. master — branch being pushed.]
git push -u origin feature/disk-alert
git fetch	[Downloads remote updates without merging them into your working branch]
git pull	[Fetches remote changes and integrates them into your current branch]
git pull --ff-only [It instructs Git to update your branch only when a fast-forward is possible. If the histories have diverged, the command stops instead of automatically creating a merge commit.]
git log --oneline --graph -6 [Graphical representation of branches] 
origin is simply a conventional remote name, not a special GitHub service or branch


## Git Fetch vs Git Pull
git fetch — downloads remote updates without changing your current working files. This downloads remote commits and updates remote-tracking references, such as origin/master. After fetch, compare the difference using git status -sb and git log commands. 
git pull — fetches and integrates remote updates into your current branch.

| Operation | `git fetch` | `git pull` |
|---|---|---|
| Downloads remote commits | Yes | Yes |
| Updates `origin/master` | Yes | Yes |
| Integrates changes into local `master` | No | Yes |
| Can modify working files | No | Yes |
| Useful for reviewing before integration | Yes | Less direct |

Recommended habit for production-related repositories: Fetch, inspect the changes, then integrate them deliberately.

inspect the difference after fetch between local repo + Remote repo
 - git log --oneline master..origin/master
 - git diff master..origin/master

git status [Check files status]
git add health.sh [add file to git]
git commit -m "Add initial server health script" [commit file]
git log --oneline [logs]
git status -sb [checks commit difference between local directory and github] [behind 1 >> This means GitHub has one commit that your local master doesn't have.]

# What is a Pull Request?
A Pull Request (PR) is a request to review and integrate changes from one branch into another. For example, you want to add a disk-space warning to health.sh. Instead of changing master directly, you create a feature branch.

A typical professional workflow:
1. Create a feature branch.
2. Make and commit changes.
3. Push the feature branch to GitHub.
4. Open a pull request. [from Github > Pull Request > Compare & Pull Request]
5. Review the code and run automated checks.
6. Merge after approval.

Git ensures that changes are tracked. Pull requests help teams review and validate those changes before integrating them into a shared branch.

Without a PR					:			With a PR
Developer merges directly				Developer proposes a merge
Review may be skipped					Reviewers can inspect changes
Tests may be skipped					Automated checks can be required
Less structured discussion				Comments and approvals are recorded
Changes may reach master immediately	Changes can be checked before merging
A PR doesn't automatically guarantee safety. Repository rules must be configured if you want to enforce approvals and passing tests.

Branch = Where you develop a feature.
Commit = A recorded snapshot of your changes.
Push = Send commits to GitHub.
Pull Request = Ask to review and merge your changes.
Merge = Integrate the approved changes into the target branch.

After the PR is merged on GitHub, you should execute below commands on Ubuntu to update your local master and verify synchronization
git switch master
git pull --ff-only
git status -sb
git log --oneline --graph -5


# GitHub Branch Protection
Without branch protection, someone with write access could accidentally push an untested change directly to master.
Common protection rules:
Rule					Purpose
Require a pull request	Prevent direct changes to the protected branch
Require approvals		Ensure another developer reviews changes
Require status checks	Ensure automated tests pass
Block force pushes		Protect shared Git history
Block branch deletion	Prevent accidental deletion of master

# merging

Q — Before merging into master:
A production-oriented workflow should be:
1. Create a Pull Request from feature/ohip-timeout to master.
2. Review the proposed changes and verify timeout behavior.
3. Run automated tests and security checks.
4. Resolve any conflicts with the latest master.
5. Obtain required approvals and merge after all checks pass.

# Github Actions and CI/CD
Without CI/CD, an engineer might manually check the code, run tests, package the application, and deploy it.
With CI/CD, much of this work can happen automatically. Push code > CI pipeline [Build + test] > Pull request [human review] > Merge to master > CD: Deploy to Staging

| Concept                     | Meaning                                                     | Example                                                      |
|-----------------------------|-------------------------------------------------------------|--------------------------------------------------------------|
| CI — Continuous Integration | Automatically validate code changes                         | Run Bash syntax checks and unit tests                        |
| Continuous Delivery         | Prepare validated changes for release                       | Build a Docker image and make it ready for deployment        |
| Continuous Deployment       | Automatically release changes after passing required checks | Deploy a validated container without manual release approval |

When you push a change to health.sh, GitHub Actions will automatically run a Bash syntax check. If the check fails, the workflow reports failure, helping reviewers identify problems before merging.


CI/CD architecture:
```mermaid
    A[Developer Writes Code] --> B[Git Commit and Push]
    B --> C[GitHub Repository]
    C --> D[GitHub Actions Trigger]
    D --> E[Ubuntu Runner]
    E --> F[Checkout Source Code]
    F --> G[Bash Syntax Validation]
    G --> H{Syntax Passed?}
    H -->|No| X[CI Failed]
    H -->|Yes| I[ShellCheck Static Analysis]
    I --> J{ShellCheck Passed?}
    J -->|No| X
    J -->|Yes| K[CI Passed]
    K --> L[Review Pull Request]
    L --> M[Merge into master]
    M --> N[Optional CD Pipeline]
    N --> O[Deploy to Staging]
    O --> P[Production Release]
```

## CI/CD Workflow

The following diagram explains how GitHub Actions validates code.

```mermaid
flowchart TD
    A[Developer Pushes Code] --> B[GitHub Actions]
    B --> C[Run Bash Syntax Check]
    C --> D[Run ShellCheck]
    D --> E{All Checks Passed?}
    E -->|Yes| F[CI Success]
    E -->|No| G[CI Failed]
    G --> H[Developer Fixes Code]
    H --> A
```

How GitHub Actions works

```mermaid

flowchart TD
    A[Git Push or Pull Request] --> B[GitHub Event]
    B --> C[Workflow ci.yml]
    C --> D[Job: validate]
    D --> E[Ubuntu Runner]
    E --> F[Checkout Repository]
    F --> G[Run Validation Commands]
    G --> H[GitHub Records Logs and Status]
	
```

| Component |     Your example     |              Meaning             |
|:---------:|:--------------------:|:--------------------------------:|
| Event     | push, pull_request   | When to start                    |
| Workflow  | Bash CI              | The overall automation           |
| Job       | validate             | Group of steps                   |
| Runner    | ubuntu-latest        | Machine executing the job        |
| Action    | actions/checkout@v4  | Reusable operation               |
| Command   | shellcheck health.sh | Shell command executed on runner |

How to troubleshoot a failed workflow
Use this sequence every time:
1. Locate the failure: Open the GitHub Actions run, identify the failed job and step.
2. Read the actual error: Record the filename, line number, diagnostic code, and exit code.
3. Reproduce locally: Run the same command on Ubuntu.
4. Correct the root cause: Avoid suppressing warnings without understanding them.
5. Validate locally: Run syntax, static analysis, and functional tests.
6. Commit and push: Let GitHub Actions run again, then inspect the new result.
Remember: a successful git push only confirms that Git accepted your changes. It does not prove that your CI pipeline passed.

## CI:

Continuous Integration: detecting problems early and providing feedback to developers.
Objective: Create workflows for Syntax check, ShellCheck
Objective: Configure GitHub so that a Pull Request cannot be merged into master unless its CI checks pass.

Term	Description
Workflow	Automated process defined in a YAML file
Event	Activity that triggers a workflow, such as push
Job	Collection of steps executed on a runner
Runner	Machine that executes the job
Step	Individual action or shell command
Action	Reusable automation component
Artifact	File produced by a workflow, such as a test report

```mermaid
flowchart TD
    A[Developer pushes code] --> B[GitHub Actions]
    B --> C[Ubuntu Runner]
    C --> D[Checkout Repository]
    D --> E[Run Bash Syntax Check]
    E --> F{Validation Passed?}
    F -->|Yes| G[CI Success]
    F -->|No| H[CI Failure]
    H --> I[Developer Fixes Code]
    I --> A
```

## First Workflow [syntax Check]
--YML--
name: Bash CI

on:
  push:
  pull_request:

jobs:
  validate:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Validate Bash syntax
        run: bash -n health.sh

      - name: Display success message
        run: echo "Bash syntax validation passed"


Understand the YAML [workflow]
| Component | Meaning                           |
|-----------|-----------------------------------|
| name      | Workflow name displayed on GitHub |
| on        | Events that trigger the workflow  | Events such as push, pull_request, workflow_dispatch, or a schedule
| jobs      | Groups of tasks to execute        |
| runs-on   | Runner environment                |
| steps     | Individual commands or actions    |
| uses      | Reuse an existing GitHub Action   |
| run       | Execute a shell command           |

A runner is a machine that executes the workflow. Here, GitHub provides an Ubuntu environment, so your personal Ubuntu VM does not execute the CI job.

## ShellCheck: Syntax vs. Code Quality
ShellCheck is a static analysis tool for shell scripts, including Bash. It examines source code without executing it and identifies potential problems such as unquoted variables, suspicious conditions, portability issues, and unreachable code

A Bash script can have valid syntax but still contain problems. You can run ShellCheck locally before pushing: shellcheck <filename>



|       Tool       |     Main purpose    |                     Example                     |
|:----------------:|:-------------------:|:-----------------------------------------------:|
| bash -n          | Syntax validation   | Detects malformed if statements                 |
| shellcheck       | Static analysis     | Detects unsafe variable expansion               |
| Functional tests | Behavior validation | Verifies that 80% disk usage produces a warning |


|                  bash -n                 |                                 ShellCheck                                |
|:----------------------------------------:|:-------------------------------------------------------------------------:|
|                  bash -n                 |                                 ShellCheck                                |
| Checks Bash syntax                       | Performs static code analysis                                             |
| Detects missing fi, invalid syntax, etc. | Detects quoting issues, suspicious expressions, common scripting mistakes |
| Does not execute the script              | Does not execute the script                                               |
| Normally silent on success               | Reports findings with line numbers and diagnostic codes                   |


|   Finding   | Severity |                             Explanation                             |
|:-----------:|:--------:|:-------------------------------------------------------------------:|
| SC2086      | Error    | Double quote to prevent globbing and word splitting.				   |
| SC2148      | Error    | ShellCheck cannot determine which shell should interpret the script |
| SC2317      | Info     | ShellCheck believes some commands are unreachable                   |
| Exit code 1 | Failure  | ShellCheck found a problem and returned a nonzero status            |

ShellCheck in CI pipeline

```mermaid
    A[Developer Pushes Bash Script] --> B[GitHub Actions]
    B --> C[Bash Syntax Check]
    C --> D[ShellCheck Analysis]
    D --> E{Warnings or Errors?}
    E -->|Yes| F[Step Fails]
    F --> G[Developer Fixes Script]
    G --> A
    E -->|No| H[Functional Tests]
    H --> I{Tests Passed?}
    I -->|Yes| J[CI Success]
    I -->|No| F
```

## Coverd 

You've practiced three important DevOps skills: diagnosing CI failures, using static analysis, and correcting Bash control flow.

## Function test
```mermaid
flowchart TD
    A[Push Code to GitHub] --> B[GitHub Actions]
    B --> C[Bash Syntax Check]
    C --> D[ShellCheck]
    D --> E[Functional Tests]
    E --> F{All Tests Pass?}
    F -->|Yes| G[CI Success]
    F -->|No| H[CI Failure]
    H --> I[Developer Fixes Code]
    I --> A
```
## Troubleshooting method to remember

```mermaid

flowchart TD
    A[GitHub Actions Failed] --> B[Identify Failed Job and Step]
    B --> C[Read Error Message and Exit Code]
    C --> D[Reproduce Error Locally]
    D --> E[Identify Root Cause]
    E --> F[Apply Fix]
    F --> G[Run Local Checks]
    G --> H[Commit and Push]
    H --> I[Inspect New GitHub Actions Run]
    I --> J{All Checks Passed?}
    J -->|No| B
    J -->|Yes| K[Review and Merge PR]


```

# Notes:
DevOps lesson: Git can track changes to file permissions even when the file contents remain identical.

git push transfers commits, not uncommitted file modifications.

After fetch you can compare code difference. The changes won't integration into your files. And you can't modify the fetched files. 

Rule to remember: Avoid force-pushing shared production branches. Use git revert when you need to reverse a published commit without rewriting history.

Important: A workflow passing does not automatically mean GitHub requires it before merging. That restriction must be configured separately.

An automation system that relies on the exit code may interpret the check as successful, even though the output reports a problem.This is why exit codes are important for CI pipelines, monitoring systems, scheduled scripts, and deployment automation.


Day	Topic	Practical
Monday		CI/CD fundamentals	Understand pipeline stages
Tuesday		GitHub Actions basics	Create your first workflow YAML
Wednesday	Automated Bash validation	Run bash -n and ShellCheck
Thursday	PR status checks	Trigger validation on pull requests
Saturday	CI pipeline project	Build and test a complete workflow
Sunday		Assessment	Troubleshoot a failing pipeline

# Labs:
mkdir -p ~/devops-git-lab
cd ~/devops-git-lab
git init

git config user.name "DevOps Student"
git config user.email "devops-student@example.invalid"

cat > health.sh <<'EOF'
#!/usr/bin/env bash
echo "Server Health Report"
hostname
uptime
EOF

GitHub Token Life Time: 
rbm179
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


Questions:
What else we can perform in Github Actions in the production environment. Give some examples in details