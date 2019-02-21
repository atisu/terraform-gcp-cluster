
resource "google_compute_instance" "master" {
   count = "${var.master_count}"
   name = "${var.instance_prefix}-m${count.index}"
   machine_type = "${var.master_machine_type}"
   zone = "${var.zone}"
   allow_stopping_for_update = true
   boot_disk {
      initialize_params {
         image = "${var.image}"
         size = "${var.disk_size}"
         type = "pd-ssd"
      }
   }

   metadata {
      ssh-keys = "${var.ssh_user}:${file(var.ssh_pub_key_file_1)} ${var.ssh_user}\n${var.ssh_user}:${file(var.ssh_pub_key_file_2)} ${var.ssh_user}"
      index = "${count.index}"
   }

   network_interface {
      subnetwork = "${google_compute_subnetwork.vpc_subnetwork.self_link}"
      access_config {
         network_tier = "STANDARD"
      }
   }

   tags = ["allow-ssh", "allow-8080", "allow-ranger-ui", "allow-yarn-ui", "allow-zeppelin-ui"]
}


resource "google_compute_instance" "worker" {
   count = "${var.worker_count}"
   name = "${var.instance_prefix}-w${count.index}"
   machine_type = "${var.worker_machine_type}"
   zone = "${var.zone}"
   allow_stopping_for_update = true
   boot_disk {
      initialize_params {
         image = "${var.image}"
         size = "${var.disk_size}"
         type = "pd-ssd"
      }
   }

   metadata {
      ssh-keys = "${var.ssh_user}:${file(var.ssh_pub_key_file_1)} ${var.ssh_user}\n${var.ssh_user}:${file(var.ssh_pub_key_file_2)} ${var.ssh_user}"
      index = "${count.index}"
   }

   network_interface {
      subnetwork = "${google_compute_subnetwork.vpc_subnetwork.self_link}"
      access_config {
         network_tier = "STANDARD"
      }
   }

   tags = ["allow-ssh"]
}


resource "google_compute_instance" "edge" {
   count = "${var.edge_count}"
   name = "${var.instance_prefix}-e${count.index}"
   machine_type = "${var.edge_machine_type}"
   zone = "${var.zone}"
   allow_stopping_for_update = true
   boot_disk {
      initialize_params {
         image = "${var.image}"
         size = "${var.disk_size}"
         type = "pd-ssd"
      }
   }

   metadata {
      ssh-keys = "${var.ssh_user}:${file(var.ssh_pub_key_file_1)} ${var.ssh_user}\n${var.ssh_user}:${file(var.ssh_pub_key_file_2)} ${var.ssh_user}"
      index = "${count.index}"
   }

   network_interface {
      subnetwork = "${google_compute_subnetwork.vpc_subnetwork.self_link}"
      access_config {
         network_tier = "STANDARD"
      }
   }

   tags = ["allow-ssh"]
}
