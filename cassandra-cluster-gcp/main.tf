variable "project" {
  type    = "string"
}

variable "mtype" {
  type    = "string"
  default = "g1-small"

}

variable "dtype" {
  type    = "string"
  default = "pd-standard"
}

variable "dsize" {
  type    = "string"
  default = "10"
}


variable "jsonpath" {
  type	  = "string"
}


provider "google" {
  credentials = "${file(${var.jsonpath})}"
  project     = "${var.project}"
  region        = "us-central1"
}

resource "google_compute_instance" "cs-1" {
  name         = "cs-1"
  machine_type = "${var.mtype}"
  zone         = "us-central1-a"

  tags = ["cassandra"]

  boot_disk {
    initialize_params {
      size = "${var.dsize}"
      image = "debian-cloud/debian-9"
      type = "${var.dtype}"
    }
  }

  network_interface {
    network = "default"

    access_config {
    }
  }
  provisioner "file" {
    source      = "deploy-cassandra.sh"
    destination = "/tmp/deploy-cassandra.sh"
     connection {
      type = "ssh"
      user = "devops"
      private_key = "${file("/home/devops/.ssh/id_rsa")}"
      agent = false
    } 
 }

  provisioner "file" {
    source      = "cassandra-rackdc.properties.1"
    destination = "/tmp/cassandra-rackdc.properties.1"
     connection {
      type = "ssh"
      user = "devops"
      private_key = "${file("/home/devops/.ssh/id_rsa")}"
      agent = false
    } 
 }

  provisioner "file" {
    source      = "cassandra.yaml"
    destination = "/tmp/cassandra.yaml"
     connection {
      type = "ssh"
      user = "devops"
      private_key = "${file("/home/devops/.ssh/id_rsa")}"
      agent = false
    } 
 }


  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "devops"
      private_key = "${file("/home/devops/.ssh/id_rsa")}"
      agent = false
    }
    inline = [
      "chmod +x /tmp/deploy-cassandra.sh",
      "/tmp/deploy-cassandra.sh",
      "sudo cp -f /tmp/cassandra.yaml /etc/cassandra/cassandra.yaml",
      "sudo cp -f /tmp/cassandra-rackdc.properties.1 /etc/cassandra/cassandra-rackdc.properties",
      "sudo service cassandra start",
    ]
  }
}

resource "google_compute_instance" "cs-2" {
  name         = "cs-2"
  machine_type = "${var.mtype}"
  zone         = "us-central1-b"

  tags = ["cassandra"]

  boot_disk {
    initialize_params {
      size = "${var.dsize}"
      image = "debian-cloud/debian-9"
      type = "${var.dtype}"
    }
  }


  network_interface {
    network = "default"

    access_config {
    }
  }
  provisioner "file" {
    source      = "deploy-cassandra.sh"
    destination = "/tmp/deploy-cassandra.sh"
     connection {
      type = "ssh"
      user = "devops"
      private_key = "${file("/home/devops/.ssh/id_rsa")}"
      agent = false
    } 
 }

  provisioner "file" {
    source      = "cassandra-rackdc.properties.2"
    destination = "/tmp/cassandra-rackdc.properties.2"
     connection {
      type = "ssh"
      user = "devops"
      private_key = "${file("/home/devops/.ssh/id_rsa")}"
      agent = false
    } 
 }

  provisioner "file" {
    source      = "cassandra.yaml"
    destination = "/tmp/cassandra.yaml"
     connection {
      type = "ssh"
      user = "devops"
      private_key = "${file("/home/devops/.ssh/id_rsa")}"
      agent = false
    } 
 }


  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "devops"
      private_key = "${file("/home/devops/.ssh/id_rsa")}"
      agent = false
    }
    inline = [
      "chmod +x /tmp/deploy-cassandra.sh",
      "/tmp/deploy-cassandra.sh",
      "sudo cp -f /tmp/cassandra.yaml /etc/cassandra/cassandra.yaml",
      "sudo cp -f /tmp/cassandra-rackdc.properties.2 /etc/cassandra/cassandra-rackdc.properties",
      "sudo service cassandra start",
    ]
  }
}

resource "google_compute_instance" "cs-3" {
  name         = "cs-3"
  machine_type = "${var.mtype}"
  zone         = "us-central1-c"

  tags = ["cassandra"]

  boot_disk {
    initialize_params {
      size = "${var.dsize}"
      image = "debian-cloud/debian-9"
      type = "${var.dtype}"
    }
  }


  network_interface {
    network = "default"

    access_config {
    }
  }
  provisioner "file" {
    source      = "deploy-cassandra.sh"
    destination = "/tmp/deploy-cassandra.sh"
     connection {
      type = "ssh"
      user = "devops"
      private_key = "${file("/home/devops/.ssh/id_rsa")}"
      agent = false
    } 
 }

  provisioner "file" {
    source      = "cassandra-rackdc.properties.3"
    destination = "/tmp/cassandra-rackdc.properties.3"
     connection {
      type = "ssh"
      user = "devops"
      private_key = "${file("/home/devops/.ssh/id_rsa")}"
      agent = false
    } 
 }

  provisioner "file" {
    source      = "cassandra.yaml"
    destination = "/tmp/cassandra.yaml"
     connection {
      type = "ssh"
      user = "devops"
      private_key = "${file("/home/devops/.ssh/id_rsa")}"
      agent = false
    } 
 }


  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "devops"
      private_key = "${file("/home/devops/.ssh/id_rsa")}"
      agent = false
    }
    inline = [
      "chmod +x /tmp/deploy-cassandra.sh",
      "/tmp/deploy-cassandra.sh",
      "sudo cp -f /tmp/cassandra.yaml /etc/cassandra/cassandra.yaml",
      "sudo cp -f /tmp/cassandra-rackdc.properties.3 /etc/cassandra/cassandra-rackdc.properties",
      "sudo service cassandra start",
    ]
  }
}
