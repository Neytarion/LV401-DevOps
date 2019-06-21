# Access the provider GCP
provider "google" {
credentials = "${file("LV-401-Devops-9958d6c885d7.json")}"
project = "lv-401-devops"
region = "us-central1-a"
}
