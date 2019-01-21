
resource "google_compute_network" "vpc_network" {
  name                    = "${var.network}"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "vpc_subnetwork" {
  name   = "${var.network}-sub"
  region = "${var.region}"
  network = "${google_compute_network.vpc_network.self_link}"
  ip_cidr_range = "10.0.0.0/16"
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

resource "google_compute_firewall" "allow-internal" {
  name    = "${google_compute_network.vpc_network.name}-allow-internal"
  network = "${google_compute_network.vpc_network.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["1-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["1-65535"]
  }

  source_ranges = ["10.0.0.0/8"]
}