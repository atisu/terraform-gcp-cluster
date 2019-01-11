# Terraform files for provisioning resources on GCP for deploying clusters with Ansible

Provision resources on GCP. It also produces an Ansible Inventory file.

## Usage

1. Install Terraform.
2. Download credentials in JSON format.
3. Copy `terraform.tfvars-sample` to `terraform.tfvars` and update contents.
4. `terraform init`.
5. `terraform apply`.
