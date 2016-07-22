# Contribution Guide

- To make changes to the project, first create a new git branch.
- Limit your changes to one single feature or bug. Having many unrelated changes in one branch makes it difficult to review.
- Feel free to make working commits as you go, but convert them into [atomic commits](https://en.wikipedia.org/wiki/Atomic_commit#Atomic_commit_convention) before opening a merge request by using [interactive rebasing](https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History#Squashing-Commits). Atomic commits make changes easier to review like topic branches and also aid rollbacks and debugging.
- Write tests for any changes in behavior and add them in the same commit where that behavior is modified. This ensures that the repo is always in a passing state. Make sure to write useful tests as this repo will automatically deploy to production after a push to master if the test suite is passing.
- Push your branch and open a pull request.
