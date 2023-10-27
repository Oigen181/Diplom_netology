terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = "ru-central1-a"
  token = "y0_AgAAAAACsMP5AATuwQAAAADck-dAeRqPwqvKSoiWy1QzA3Lw6QDapfY"
  cloud_id = "b1gg2hr8eb22j7ht320k"
  folder_id = "b1g4h7anelqa7bko9vvb"
}


resource "yandex_compute_instance" "vm-1" {

  name                      = "linux-vm1"
  allow_stopping_for_update = true
  platform_id               = "standard-v3"
  zone                      = "ru-central1-a"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8tgblovu5dklvrp29h"
      size     = 10
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.yaml")}"
  }
}

resource "yandex_vpc_network" "test-1" {
  name = "networkmy"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  v4_cidr_blocks = ["192.168.10.0/24"]
  network_id     = "${yandex_vpc_network.test-1.id}"
}

resource "yandex_compute_instance" "vm-2" {

  name                      = "linux-vm2"
  allow_stopping_for_update = true
  platform_id               = "standard-v3"
  zone                      = "ru-central1-b"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8tgblovu5dklvrp29h"
      size     = 10
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet-2.id}"
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.yaml")}"
  }
}

resource "yandex_vpc_subnet" "subnet-2" {
  name           = "subnet2"
  zone           = "ru-central1-b"
  v4_cidr_blocks = ["192.168.10.0/24"]
  network_id     = "${yandex_vpc_network.test-1.id}"
}

resource "yandex_alb_target_group" "targets" {
  name           = "targetos"

  target {
    subnet_id    = yandex_vpc_subnet.subnet-1.id
    ip_address   = yandex_compute_instance.vm-1.network_interface.0.ip_address
  }

  target {
    subnet_id    = yandex_vpc_subnet.subnet-2.id
    ip_address   = yandex_compute_instance.vm-2.network_interface.0.ip_address
  }
}

resource "yandex_alb_backend_group" "albgroup" {
  name                     = "albgroup"
  session_affinity {
    connection {
      source_ip = true
    }
  }

  http_backend {
    name                   = "back1"
    weight                 = 1
    port                   = 80
    target_group_ids       = ["${yandex_alb_target_group.targets.id}"]
    load_balancing_config {
      panic_threshold      = 90
    }
    healthcheck {
      timeout              = "10s"
      interval             = "2s"
      healthy_threshold    = 10
      unhealthy_threshold  = 15
      http_healthcheck {
        path               = "/"
      }
    }
  }
}


resource "yandex_alb_http_router" "router-1" {
  name          = "router-12"
}

resource "yandex_alb_virtual_host" "vh-1" {
  name                    = "vh-1"
  http_router_id          = "${yandex_alb_http_router.router-1.id}"
  route {
    name                  = "myroute"
    http_route {
      http_route_action {
        backend_group_id  = "${yandex_alb_backend_group.albgroup.id}"
        timeout           = "60s"
      }
    }
  }
}  


resource "yandex_alb_load_balancer" "balancertest" {
  name        = "alb-1"
  network_id  = "${yandex_vpc_network.test-1.id}"

  allocation_policy {
    location {
      zone_id   = "ru-central1-a"
      subnet_id = "${yandex_vpc_subnet.subnet-1.id}" 
    }
  }

  listener {
    name = "listener-1"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [ 80 ]
    }
    http {
      handler {
        http_router_id = "{yandex_alb_http_router.router-1.id}"
      }
    }
  }
}
