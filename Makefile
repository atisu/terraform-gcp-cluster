
.PHONY: usage

usage:
	@echo " usage: make clean|set-name|plan|init|apply|list-ips|destroy\n"
	@echo "  clean:\t remove all generated files"
	@echo "  init:\t\t run terraform init"
	@echo "  set-name:\t set prefix and network name for instances"
	@echo "  plan:\t\t run terraform plan"
	@echo "  apply:\t create or update instances and inventory file via terraform"
	@echo "  list-ips:\t list instance ips from GCP"
	@echo "  destroy:\t destroy all resources via terraform"
	@echo "\n"

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
	@cp inventory ../opserv-keel/ansible/inventory/static/00-static

destroy:
	terraform destroy
