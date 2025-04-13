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
	echo "[INFO] origin/staging から新しいローカル staging ブランチを作成します。" && \
	(git branch -D staging 2>/dev/null || true) && \
	git checkout -b staging origin/staging && \
	echo "[INFO] $$CURRENT_BRANCH の変更を staging に rebase します。" && \
	git rebase $$CURRENT_BRANCH && \
	echo "[INFO] origin/staging に強制 push します。" && \
	git push --force origin staging && \
	git checkout $$CURRENT_BRANCH && \
	echo "[INFO] staging ブランチを削除します。" && \
	git branch -D staging
