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

## Terraform plan
.PHONY: plan
plan:
	cd terraform && terraform plan -var-file=".workspace.tfvars"

## Terraform apply
.PHONY: apply
apply:
	cd terraform && terraform apply -var-file=".workspace.tfvars"

## Terraform destroy
.PHONY: destroy
destroy:
	cd terraform && terraform destroy -var-file=".workspace.tfvars"

## Remove Terraform state
.PHONY: destroy-tf-state
include .workspace.env
destroy-tf-state:
	az group delete --no-wait --name $(TF_STATE_RG_NAME)
