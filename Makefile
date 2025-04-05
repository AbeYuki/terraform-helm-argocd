
deploy-staging:
	@CURRENT_BRANCH=$$(git symbolic-ref --short HEAD); \
	if [ "$$CURRENT_BRANCH" = "main" ] || [ "$$CURRENT_BRANCH" = "master" ]; then \
		echo "'$$CURRENT_BRANCH' ブランチからは deploy-staging は実行できません。開発用ブランチで実行してください。"; \
		exit 1; \
	fi && \
	if ! git diff-index --quiet HEAD --; then \
		echo "未コミットの変更があります。commit してください。" && exit 1; \
	fi && \
	echo "現在のブランチ: $$CURRENT_BRANCH" && \
	git fetch origin && \
	echo "origin/main から staging ブランチを作成します。" && \
	(git branch -D staging 2>/dev/null || true) && \
	git checkout -b staging origin/main && \
	echo "staging ブランチに origin/staging の履歴を取り込みます。" && \
	(git merge --no-ff origin/staging -m "Merge origin/staging into staging by 'make deploy-staging'" || true) && \
	echo "$$CURRENT_BRANCH ブランチの変更を staging ブランチにマージします。" && \
	git merge --no-ff $$CURRENT_BRANCH -m "Merge from $$CURRENT_BRANCH by 'make deploy-staging'" && \
	git push origin staging && \
	git checkout $$CURRENT_BRANCH && \
	echo "staging ブランチを削除します。" && \
	git branch -D staging