terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
}

## Crinando os servidores

resource "digitalocean_droplet" "droplet-postgres-01" {
  image    = "ubuntu-23-10-x64"
  name     = "droplet-postgres-01"
  region   = "nyc3"
  size     = "s-1vcpu-1gb"
  tags     = ["owner:felipe", "lab:postgres", "issue:teste"]
  ssh_keys = [35951729]


  connection {
    type        = "ssh"
    user        = "root"
    private_key = file("/ssh-chaves/digital-ocean/ssh.felipe.digital-ocean")
    timeout     = "1m"
    host        = digitalocean_droplet.droplet-postgres-01.ipv4_address
  }


  provisioner "file" {
    source      = "scripts/install_postgres_16.sh"
    destination = "/tmp/install_postgres.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install_postgres.sh",
      "/tmp/install_postgres.sh"
    ]
  }
}



resource "digitalocean_droplet" "droplet-postgres-02" {
  image    = "ubuntu-23-10-x64"
  name     = "droplet-postgres-02"
  region   = "nyc3"
  size     = "s-1vcpu-1gb"
  tags     = ["owner:felipe", "lab:postgres", "issue:teste"]
  ssh_keys = [35951729]


  connection {
    type        = "ssh"
    user        = "root"
    private_key = file("/ssh-chaves/digital-ocean/ssh.felipe.digital-ocean")
    timeout     = "1m"
    host        = digitalocean_droplet.droplet-postgres-02.ipv4_address
  }


  provisioner "file" {
    source      = "scripts/install_postgres_16.sh"
    destination = "/tmp/install_postgres.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install_postgres.sh",
      "/tmp/install_postgres.sh"
    ]
  }


}

## Saidas

output "droplet-01" {
  value = [digitalocean_droplet.droplet-postgres-01.name, digitalocean_droplet.droplet-postgres-01.ipv4_address]
}

output "droplet-02" {
  value = [digitalocean_droplet.droplet-postgres-02.name, digitalocean_droplet.droplet-postgres-02.ipv4_address]
}