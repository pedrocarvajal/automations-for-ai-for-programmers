.ONESHELL:
.PHONY: run-submodules-synchronization run-submodules-push help

run-submodules-synchronization:
	git submodule update --remote --recursive

run-submodules-push:
	@if [ -z "$$(git submodule status 2>/dev/null)" ]; then \
		echo "No submodules found"; \
	else \
		git submodule foreach 'if [ -n "$$(git status --porcelain)" ]; then echo "Pushing changes in $$name..."; git add . && git commit -m "Update submodule" && git push; else echo "No changes in $$name"; fi'; \
	fi
