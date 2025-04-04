
staging-deploy:
	git fetch -a
	git checkout staging 2>/dev/null || git checkout -b staging origin/staging
	git merge --no-ff origin/main
	git push origin staging