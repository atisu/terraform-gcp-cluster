
resource "google_compute_network" "vpc_network" {
  name                    = "${var.network}"
  auto_create_subnetworks = "true"
}

resource "google_compute_firewall" "allow-8080" {
  name    = "${google_compute_network.vpc_network.name}-allow-8080"
  network = "${google_compute_network.vpc_network.name}"

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  target_tags = ["allow-8080"]
  source_ranges = "${var.allowed_ip_ranges}"
}

resource "google_compute_firewall" "allow-ssh" {
  name    = "${google_compute_network.vpc_network.name}-allow-ssh"
  network = "${google_compute_network.vpc_network.name}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["allow-ssh"]
  source_ranges = "${var.allowed_ip_ranges}"
}