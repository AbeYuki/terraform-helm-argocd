
staging-deploy:
	@CURRENT_BRANCH=$$(git symbolic-ref --short HEAD) && \
	echo "Current branch: $$CURRENT_BRANCH" && \
	git fetch origin && \
	git checkout staging && \
	git merge --no-ff $$CURRENT_BRANCH -m "Merge from $$CURRENT_BRANCH" && \
	git push origin staging && \
	git checkout $$CURRENT_BRANCH