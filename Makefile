
deploy-staging:
	@CURRENT_BRANCH=$$(git symbolic-ref --short HEAD); \
	if [ "$$CURRENT_BRANCH" = "main" ] || [ "$$CURRENT_BRANCH" = "master" ]; then \
		echo "'[ERROR] $$CURRENT_BRANCH' ブランチからは deploy-staging は実行できません。開発用ブランチで実行してください。"; \
		exit 1; \
	fi && \
	if ! git diff-index --quiet HEAD --; then \
		echo "[ERROR] commit されていない変更があります。commit してください。" && exit 1; \
	fi && \
	echo "[INFO] 現在のブランチ: $$CURRENT_BRANCH" && \
	git fetch origin && \
	echo "[INFO] origin/main から staging ブランチを作成します。" && \
	(git branch -D staging 2>/dev/null || true) && \
	git checkout -b staging origin/main && \
	echo "[INFO] staging ブランチに origin/staging の履歴を取り込みます。" && \
	(git merge --no-ff origin/staging -m "Merge origin/staging into staging by 'make deploy-staging'" || true) && \
	echo "[INFO] $$CURRENT_BRANCH ブランチの変更を staging ブランチにマージします。" && \
	git merge --no-ff $$CURRENT_BRANCH -m "Merge from $$CURRENT_BRANCH by 'make deploy-staging'" && \
	echo "[INFO] origin/staging に push します。" && \
	git push origin staging && \
	git checkout $$CURRENT_BRANCH && \
	echo "[INFO] staging ブランチを削除します。" && \
	git branch -D staging