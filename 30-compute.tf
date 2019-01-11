
resource "google_compute_instance" "master" {
   count = "${var.master_count}"
   name = "${var.instance_prefix}-m${count.index}"
   machine_type = "${var.machine_type}"
   zone = "${var.zone}"
   boot_disk {
      initialize_params {
         image = "${var.image}"
         size = "${var.disk_size}"
      }
   }

   metadata {
      sshKeys = "${var.ssh_user}:${file(var.ssh_pub_key_file)}"
      index = "${count.index}"
   }

   network_interface {
      network = "${google_compute_network.vpc_network.self_link}"
      access_config {
         network_tier = "STANDARD"
      }
   }

   tags = ["allow-ssh", "allow-8080"]
}


resource "google_compute_instance" "worker" {
   count = "${var.worker_count}"
   name = "${var.instance_prefix}-w${count.index}"
   machine_type = "${var.machine_type}"
   zone = "${var.zone}"
   boot_disk {
      initialize_params {
         image = "${var.image}"
         size = "${var.disk_size}"
      }
   }

   metadata {
      sshKeys = "${var.ssh_user}:${file(var.ssh_pub_key_file)}"
      index = "${count.index}"
   }

   network_interface {
      network = "${google_compute_network.vpc_network.self_link}"
      access_config {
         network_tier = "STANDARD"
      }
   }

   tags = ["allow-ssh"]
}


resource "google_compute_instance" "edge" {
   count = "${var.edge_count}"
   name = "${var.instance_prefix}-e${count.index}"
   machine_type = "${var.machine_type}"
   zone = "${var.zone}"
   boot_disk {
      initialize_params {
         image = "${var.image}"
         size = "${var.disk_size}"
      }
   }

   metadata {
      sshKeys = "${var.ssh_user}:${file(var.ssh_pub_key_file)}"
      index = "${count.index}"
   }

   network_interface {
      network = "${google_compute_network.vpc_network.self_link}"
      access_config {
         network_tier = "STANDARD"
      }
   }

   tags = ["allow-ssh"]
}
