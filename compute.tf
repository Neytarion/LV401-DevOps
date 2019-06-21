### To Provision FireWall rule ###

resource "google_compute_firewall" "www" {
  name = "jenkins-lv401-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["8080", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
}


### To provision Jenkins Master ###

resource "google_compute_instance" "jenkins-master-1" {
   name = "jenkins-master-lv401"
   machine_type = "n1-standard-1"
   zone = "us-central1-a"
   tags = ["jenkins"]
   boot_disk {
      initialize_params {
      image = "centos-7"
   }
}
network_interface {
   network = "default"
   access_config {}
}
service_account {
   scopes = ["userinfo-email", "compute-ro", "storage-ro"]
   }

 metadata_startup_script = "sudo yum install -y wget"
}

output "public_ip_master" {
   value = ["${google_compute_instance.jenkins-master-1.*.network_interface.0.access_config.0.assigned_nat_ip}"]
}
