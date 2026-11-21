

What problem does Git solve for a system administrator? *Answer*: it makes file changes tracking easy. 
[Correct. Tracks file changes and allows recovery of previous versions.]

What is the difference between git add and git commit? *Answer*: <git add> it stage changes for a commit or tells that there are not chages to staged <git commit> records the chages.
[Correct. add stages content; commit records the staged snapshot.]

What does git status tell you? *Answer*: it is used to see the chagess or files that are not staged yet. 
[Correct, but it also shows staged changes and branch status.]
Where is Git storing the version history in your new project? *Answer*: it is storing the files to git user and email address we added during practive
[Git stores repository history locally in .git, not in your username/email.]

If you change health.sh after committing, will Git automatically create a new commit? *Answer*: No, we need to commit after every chages
[Correct. Changing a file does not automatically create a commit.]

If you run git commit now, will the commit contain only the disk-usage section, or both disk and memory sections? *Answer*: ONLY the disk-usage becuase memory usage is not added into staged area. 

What are Git's three main areas? *Answer*: 1) Working Directory 2) Staging Area 3) Local repository
What is the difference between git diff and git diff --staged? *Answer*: git diff shows difference in unstaging area, dit diff --staged shows difference in staging area.
If you stage a file and then modify it again, will Git automatically update the staged version? *Answer*: No, we'll need to add it into staging area again. 
In Lab 3, what happens if you commit without running git add again? *Answer*: ONLY the disk-usage will be commited becuase memory usage was not added into staged area. 
Why might a system administrator prefer two separate commits rather than one large commit? *Answer*: It is easy to track / revert to specific version / change history


What is the purpose of creating a Git branch? *Answer*: It allows different team to work on the same file and develope a feature
What is the difference between git branch and git switch? *Answer*:  git branch lists down branches while git switch > switch the branch to do different one. 
Why did the nginx section disappear when you switched back to master before merging? *Answer*: becuase changes were NOT made on branch master branch. 
What is a fast-forward merge? *Answer*: A fast-forward merge in Git occurs when the target branch has no new commits since the source branch branched off
Does deleting a merged feature branch remove its changes from master? *Answer*: No, becuase change are already merged to master branch. 

Part A — Git fundamentals
1. What are the three main areas in Git? *Answer*: working Directory, staging area, Local repository
2. Explain the difference between git add and git commit. *Answer*: git add > add the files into staging area git commit > add the files into local repository
3. What is the difference between git diff and git diff --staged? *Answer*: git diff shows difference in unstaging area, dit diff --staged shows difference in staging area.
4. Where does Git store repository history? *Answer*: git stores repository history in locally int .git
5. What does HEAD represent? *Answer*: HEAD represent the last commited repository
[HEAD refers to the currently checked-out commit, usually through the current branch. Normally, HEAD points to the current branch, and that branch points to its latest commit. In detached HEAD mode, HEAD points directly to a commit.]

Part B — Recovery and branching
6. You modified health.sh but haven't staged it. Which command can discard the changes? *Answer*: git restore health.sh
7. You staged a file accidentally but want to keep its modifications. What command would you use? *Answer*: git restore --staged health.sh
8. What is the difference between git revert and git restore? *Answer*: git restores files from staging or unstaging area while git revert restore committed changes. 
9. What is a fast-forward merge? *Answer*: a fast-forward merge happns on the very latest commit. 
10. Why can a merge conflict happen when two engineers modify the same file? *Answer*: Because they committed on same line. 
[Overlapping changes can cause conflicts]

art C — Production scenario
You manage a Git repository containing Docker Compose files and Bash deployment scripts.
An engineer merges a change into master. The merge succeeds, but the application fails after deployment.
Explain your investigation in 5–7 steps, covering how you would identify the change, examine the difference, validate the configuration, and safely recover.

1. Confirm the incident and deployment version.
2. Identify the changes.
3. Compare against the known-good version.
4. Validate configuration.
5. Decide on rollback or correction.
6. Verify recovery.
7. Document the root cause and permanent fix.


Q1. What does origin represent in your Git configuration? It's a destination on remote
Q2. If you modify health.sh but don't commit it, will git push upload those changes to GitHub? Why? No, to push it to repository, you need to push it to manually using specific command. 
Q3. What does the following indicate? Answer: Uncommitted update. 
## master...origin/master
 M health.sh
 
 
 
Q1. What is the difference between git fetch and git pull? *Answer: * Git fetch download the files but won't integrate into your files. You can compare difference between local and remote repo. Git Pull will download and integrate the changed into your files. 

Q2. After running git fetch, Git shows: *Answer: *  This means GitHub has one commit that your local master doesn't have.

Q3. Why didn't your local health.sh change immediately after running git fetch? *Answer: * Because git fetch will not integrate changes into your files. 

Q4. What is the benefit of using git pull --ff-only instead of a regular git pull? *Answer: * It instructs Git to update your branch only when a fast-forward is possible. If the histories have diverged, the command stops instead of automatically creating a merge commit.

Q5. If your local master contains two commits that haven't been pushed, and GitHub contains one different commit, will git pull --ff-only succeed? Explain why. No. it's possible with fast-forward only. [Your local branch has commits C and D, while GitHub has commit E. Neither branch is a direct continuation of the other. Therefore, git pull --ff-only cannot advance your local branch without reconciling the divergent histories. You would need an appropriate merge or rebase strategy.]

git status -sb
## master...origin/master
muhammad@ubuntuserver:~/devops-git-lab$ git log --oneline -5
3dee9a8 (HEAD -> master, origin/master) Update health.sh
4429f18 Make health monitoring script executable
335b0f8 Add nginx service health check
1f71e21 Revert "Add network information to health script"
daaeed1 Add network information to health script
muhammad@ubuntuserver:~/devops-git-lab$ tail -n 5 health.sh
if systemctl is-active --quiet nginx; then
    echo "Nginx is running"
else
    echo "Nginx is not running"
fi

I used a different commit name in Github, hope it's not an issue. 

What is the difference between a Git commit and a GitHub pull request? *Answer: * Git commits changes in local repository. GitHub Pull is a request to review and integrate changes from one branch into another
Why should a production team avoid pushing directly to master? *Answer: * The code should be reviewd first before pushing it to avoid creating issue in the productions. 
What is the difference between the base and compare branches in a pull request? *Answer: * Base branch is the main (master) branch and compare branch is the newly created feature branch. 
If a reviewer requests a correction, do you need to create a new pull request, or can you push another commit to the same feature branch? *Answer: * Yes, reviewer needs to review  the new changes. 

https://github.com/rbm179/devops-health-monitor/compare/master...feature/disk-alert?expand=1


Why should we validate disk_usage before comparing it with 80?  *Answer:* Because we want script to return an appropriate nonzero exit satus if monitoring fails. 
[Your answer about returning a nonzero exit status is related, but the main reason is to ensure that disk_usage contains a valid number before performing a numeric comparison.
Validation prevents misleading monitoring results and allows the script to handle invalid input safely]
What is the purpose of bash -n health.sh? *Answer:* [This checks the Bash script's syntax without executing its commands.] 
Why did git push update your existing pull request rather than create another one? *Answer:* Because we pointed it to existing branch before started working on it.
Why is checking a script's exit code important when the script will eventually run through cron, a CI/CD pipeline, or a monitoring system?
[An exit code tells another program whether a command completed successfully or failed, not merely whether it executed.] 
If the result is 0, automation tools generally interpret that as success.
If the result is nonzero, a CI/CD pipeline can fail the job, or a monitoring system can trigger an alert.
Important: A script can execute and still fail. It can also print an error but return 0 if its error handling is incorrect.


What is the purpose of branch protection? *Answer*: So we can protect our main brnach
Why should a production repository require a pull request before merging into master? *Answer*: so no one accidentally merge the unwanted code drecly into master branch. 
What is the difference between a required approval and a required status check? *Answer*: It requires code should be reviewed by another developer. Status Check= Ensure automated test pass
Why is allowing force pushes to master risky? *Answer*: [A force push can replace the remote branch's history with your local history.]
If you're the only developer, what problem might occur when you configure one mandatory reviewer approval? *Answer*: [If GitHub enforces a rule requiring approval from another eligible reviewer, you cannot satisfy it by approving your own pull request.]

What is the difference between a GitHub ruleset and a pull request? *Answer*: Rulesets enforce repository policies; PRs propose changes
Why should force pushes be blocked on master? *Answer*: A force push can replace the remote branch's history with your local history.
What happens if a developer tries to push directly to a branch protected by a rule requiring pull requests? *Answer*:  when a rule requiring pull requests is enforced, an unauthorized direct push to master is rejected by GitHub.
Why should you synchronize local master after merging a PR on GitHub? *Answer*: to make sure that local files are synced with remote repo. 
Does a clean Git working tree guarantee that your Bash script works correctly? Why? *Answer*: No. A clean tree means no pending tracked changes, not that the script is functionally correct.

Q — Before merging into master:
A production-oriented workflow should be:
1. Create a Pull Request from feature/ohip-timeout to master.
2. Review the proposed changes and verify timeout behavior.
3. Run automated tests and security checks.
4. Resolve any conflicts with the latest master.
5. Obtain required approvals and merge after all checks pass.

Q — How to resolve a merge conflict
The developer must examine both changes, decide on the correct value with the team, and edit the file to remove the conflict markers.
Important: Never choose a conflict resolution solely because one side is newer. The correct choice depends on application requirements.

Q: What is the difference between bash -n and ShellCheck? *Asnwer*:  bash -n detects if there is a syntax error. ShellCheck Detects quoting issues, suspicious expressions, common scripting mistakes
Q: Did ShellCheck identify any warnings or errors in your existing health.sh? *Asnwer*: Yes, It failed to execute. Error: Process completed with exit code 1.
Q: If the Bash syntax check passes but ShellCheck fails, what will happen to the CI workflow? *Asnwer*: IMO, Workflow will not succeed. 


Q: What is the difference between syntax validation, static analysis, and functional testing? *Asnwer*: syntax validation validates the syntax of the code, static analysis validates common mistakes of the code, functional testing validates if the result is expected or unexpected. 
Q: Why are we testing disk usage values such as 79, 80, and 95, rather than relying on the Ubuntu server's actual disk usage? *Asnwer*: We test predefined disk usage values to verify the function's behavior under different conditions, especially at boundary values such as 79% and 80%. This makes testing predictable, repeatable, and independent of the server's actual disk usage. boundry testing, Predictable results and Repeatability. Values 79 and 80 verify behavior immediately below and at the warning threshold. Using fixed inputs also makes the tests repeatable, regardless of the server's actual disk usage
Q: Why does the test script check both the function's output and its exit code? *Asnwer*: We validate both the function's output and exit code because the output provides a human-readable result, while the exit code provides a machine-readable status. Checking both ensures that the function returns the correct message and the correct status for each test scenario.