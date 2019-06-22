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
      image = "debian-cloud/debian-9"
   }
}
network_interface {
   network = "default"
   access_config {}
}
service_account {
   scopes = ["userinfo-email", "compute-ro", "storage-ro"]
   }

 metadata_startup_script = "sudo apt-get update;sudo apt install -y openjdk-8-jdk ;sudo apt-get install -y apt-transport-https; wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -; sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'; sudo apt-get update; sudo apt-get install -y jenkins; sudo apt-get install -y git; sudo git clone https://github.com/Neytarion/jenkins_xml; sudo cp jenkins_xml/config.xml /var/lib/jenkins; sudo service jenkins restart; "
}


