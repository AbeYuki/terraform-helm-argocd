
deploy-staging:
	@if ! git diff-index --quiet HEAD --; then \
		echo "未コミットの変更があります。commit してください。" && exit 1; \
	fi && \
	CURRENT_BRANCH=$$(git symbolic-ref --short HEAD) && \
	echo "現在のブランチ: $$CURRENT_BRANCH" && \
	git fetch origin && \
	(git branch -D staging 2>/dev/null || true) && \
	(git checkout -b staging origin/staging 2>/dev/null || git checkout -b staging origin/main) && \
	git merge --no-ff $$CURRENT_BRANCH -m "Merge from $$CURRENT_BRANCH" && \
	git push origin staging && \
	git checkout $$CURRENT_BRANCH