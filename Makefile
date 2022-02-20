## Check subscription and initialize env variables
.PHONY: init-variables
init-variables:
	python3 set_workspace.py

## Create terraform remote state
.PHONY: create-tf-state
create-tf-state:
	scripts/create_tf_remote_state.sh

## Initialize terraform remote state
.PHONY: init
init:
	scripts/init_remote_tf_state.sh
