.PHONY: bootstrap doctor macos-review macos-apply npmrc gh-auth asdf-setup

bootstrap:
	./bootstrap.sh

doctor:
	./doctor.sh

macos-review:
	./macos/defaults.sh --review

macos-apply:
	./macos/defaults.sh --apply

npmrc:
	cp npm/.npmrc.example "$(HOME)/.npmrc"

gh-auth:
	gh auth login

asdf-setup:
	./scripts/asdf-setup.sh
