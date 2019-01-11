
output "master_ips" {
   value = "${join(" ", google_compute_instance.master.*.network_interface.0.access_config.0.assigned_nat_ip)}"
}

output "worker_ips" {
   value = "${join(" ", google_compute_instance.worker.*.network_interface.0.access_config.0.assigned_nat_ip)}"
}

resource "null_resource" "ansible-inventory" {
  depends_on = ["google_compute_instance.worker", "google_compute_instance.edge", "google_compute_instance.master"]

  provisioner "local-exec" {
    command = "rm -rf inventory"
  }

  provisioner "local-exec" {
    command = "echo \"${join(
      "\n",
      formatlist(
        "\n[hdp-master-%s]\n%s ansible_host=%s\n",
        google_compute_instance.master.*.metadata.index,
        google_compute_instance.master.*.name,
        google_compute_instance.master.*.network_interface.0.network_ip))}\" >> inventory"
  }

  provisioner "local-exec" {
    command = "echo \"\n[hdp-edges]\n${join(
      "\n",
      formatlist(
        "%s ansible_host=%s",
        google_compute_instance.edge.*.name,
        google_compute_instance.edge.*.network_interface.0.network_ip))}\" >> inventory"
  }

  provisioner "local-exec" {
    command = "echo \"\n[hdp-workers]\n${join(
      "\n",
      formatlist(
        "%s ansible_host=%s",
        google_compute_instance.worker.*.name,
        google_compute_instance.worker.*.network_interface.0.network_ip))}\" >> inventory"
  }

  provisioner "local-exec" {
    command = "echo \"\n[all:vars]\nansible_user=${var.ssh_user}\" >> inventory"
  }

}
