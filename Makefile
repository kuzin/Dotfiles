.PHONY: bootstrap doctor sync asdf-setup

bootstrap:
	./bootstrap.sh

doctor:
	./doctor.sh

sync:
	git pull --ff-only
	./bootstrap.sh
	./doctor.sh

asdf-setup:
	./scripts/asdf-setup.sh
