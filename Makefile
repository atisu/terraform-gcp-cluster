
.PHONY: usage

usage:
	@echo "make|clean|set-name|plan|init|apply|list-ips\n"

plan:
	terraform plan

clean:
	rm -f inventory terraform.tfstate terraform.tfstate.backup
	rm -rf .terraform

init:
	terraform init

set-name:
	@sed -i.bak -e 's/^instance_prefix.*/instance_prefix="$(NAME)"/g' terraform.tfvars
	@sed -i.bak -e 's/^network.*/network="$(NAME)"/g' terraform.tfvars

list-ips:
	@gcloud compute instances list | grep $(shell cat terraform.tfvars | grep prefix | tr '=' ' ' | tr -d '\"' | awk {'print $$2'})

apply:
	terraform apply
	@cp inventory ../opserv-keel/ansible/inventory/00-static

