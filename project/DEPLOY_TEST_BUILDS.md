1. change branch to test-deploy (it exists on remote so may need to fetch first)
  - `git switch test-deploy`
2. rebase test-deploy onto main
  - `git pull -r origin main`
3. make test-deploy-issue from test-deploy
  - `git switch -c test-deploy-issueXXX`
4. merge issue branch on test deploy
  - `git merge user/issueXXX`
5. commit to remote with tracking
  - `git push --set-upstream origin test-deploy-issueXXX`
6. tag commit with "test*" prefix
  - `git tag -a test000-issueXXX -m "testing somethings from issueXXX"`
7. push tag
  - `git push origin --tags`
* build will fire automatically on tag push.
