## Check subscription and initialize env variables
.PHONY: init
init:
	python3 set_workspace.py

## Create terraform remote state
.PHONY: create-tf-state
create-tf-state:
	scripts/create_tf_remote_state.sh
