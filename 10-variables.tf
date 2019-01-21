variable "ssh_user" {
   default = "default"
}
variable "ssh_pub_key_file" {
   default = "default"
}
variable "project" {
   default = "default"
}
variable "credentials" {
   default = ""
}

variable "allowed_ip_ranges" {
   default = []
}

variable "zone" {
   default = "europe-west1-b"
}

variable "region" {
   default = "europe-west1"
}

variable "disk_size" {
   default = "10"
}

variable "master_count" {
   default = 1
}

variable "worker_count" {
   default = 1
}

variable "edge_count" {
   default = 1
}

variable "machine_type" {
   default = "n1-standard-1"
}

variable "instance_prefix" {
   default = "tf"
}

variable "network"  {
   default = "default"
}

variable "image" {
   default = "centos-7-v20180911"
}


