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
}


## Saidas

output "droplet-01" {
  value = [digitalocean_droplet.droplet-postgres-01.name, digitalocean_droplet.droplet-postgres-01.ipv4_address]
}

