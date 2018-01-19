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
  type	 = "string"
}


provider "google" {
  credentials = "${var.jsonpath}"
  project     = "${var.project}"
  region        = "us-central1"
}

/*resource "google_compute_firewall" "kibana" {
  name    = "kibana"
  network = "default"


  allow {
    protocol = "tcp"
    ports    = ["443" ]
  }



  allow {
    protocol = "tcp"
    ports    = ["80" ]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["kibana"]
}*/


resource "google_compute_instance" "influxdb-1" {
  name         = "influxdb-1"
  machine_type = "${var.mtype}"
  zone         = "us-central1-a"

  tags = ["influx"]

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
    source      = "deploy-influxdb.sh"
    destination = "/tmp/deploy-influxdb.sh"
     connection {
      type = "ssh"
      user = "devops"
      private_key = "${file("/home/devops/.ssh/id_rsa")}"
      agent = false
    } 
 }

  provisioner "file" {
    source      = "haproxy.cfg"
    destination = "/tmp/haproxy.cfg"
     connection {
      type = "ssh"
      user = "devops"
      private_key = "${file("/home/devops/.ssh/id_rsa")}"
      agent = false
    }
 }



  provisioner "file" {
    source      = "influxdb-relay.conf"
    destination = "/tmp/influxdb-relay.conf"
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
      "chmod +x /tmp/deploy-influxdb.sh",
      "sudo /tmp/deploy-influxdb.sh",
      "sudo cp -f /tmp/haproxy.cfg /etc/haproxy/haproxy.cfg",
      "sudo cp -f /tmp/influxdb-relay.conf /etc/influxdb-relay/influxdb-relay.conf",
      "sudo systemctl restart influxdb",
      "sudo systemctl restart influxdb-relay",
      "sudo systemctl restart haproxy",
    ]
  }
}

resource "google_compute_instance" "influxdb-2" {
  name         = "influxdb-2"
  machine_type = "${var.mtype}"
  zone         = "us-central1-b"

  tags = ["influxdb"]

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
    source      = "deploy-influxdb.sh"
    destination = "/tmp/deploy-influxdb.sh"
     connection {
      type = "ssh"
      user = "devops"
      private_key = "${file("/home/devops/.ssh/id_rsa")}"
      agent = false
    } 
 }

  provisioner "file" {
    source      = "haproxy.cfg"
    destination = "/tmp/haproxy.cfg"
     connection {
      type = "ssh"
      user = "devops"
      private_key = "${file("/home/devops/.ssh/id_rsa")}"
      agent = false
    }
 }

  provisioner "file" {
    source      = "influxdb-relay.conf"
    destination = "/tmp/influxdb-relay.conf"
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
      "chmod +x /tmp/deploy-influxdb.sh",
      "sudo /tmp/deploy-influxdb.sh",
      "sudo cp -f /tmp/haproxy.cfg /etc/haproxy/haproxy.cfg",
      "sudo cp -f /tmp/influxdb-relay.conf /etc/influxdb-relay/influxdb-relay.conf",
      "sudo systemctl restart influxdb",
      "sudo systemctl restart influxdb-relay",
      "sudo systemctl restart haproxy",
    ]
  }

}


/*resource "google_compute_instance" "kb-1" {
  name         = "kb-1"
  machine_type = "${var.mtype}"
  zone         = "us-central1-a"

  tags = ["kibana"]

  boot_disk {
    initialize_params {
      size = "10"
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
    source      = "deploy-kibana.sh"
    destination = "/tmp/deploy-kibana.sh"
     connection {
      type = "ssh"
      user = "devops"
      private_key = "${file("/home/devops/.ssh/id_rsa")}"
      agent = false
    } 
 }

  provisioner "file" {
    source      = "kibana"
    destination = "/tmp/kibana"
     connection {
      type = "ssh"
      user = "devops"
      private_key = "${file("/home/devops/.ssh/id_rsa")}"
      agent = false
    } 
 }



  provisioner "file" {
    source      = "kibana.yml"
    destination = "/tmp/kibana.yml"
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
      "chmod +x /tmp/deploy-kibana.sh",
      "sudo /tmp/deploy-kibana.sh",
      "sudo systemctl restart haproxy",
      "sudo cp -f /tmp/kibana.yml /etc/kibana/kibana.yml",
      "sudo cp -f /tmp/kibana /etc/nginx/sites-available/kibana",
      "sudo ln -s /etc/nginx/sites-available/kibana /etc/nginx/sites-enabled/kibana",
      "sudo rm -f /etc/nginx/sites-enabled/default",
      "sudo systemctl restart kibana",
      "sudo systemctl restart nginx",
    ]
  }
}
*/