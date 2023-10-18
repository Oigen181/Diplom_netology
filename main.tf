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
  token = var.yc_token #from ./token.tf
  cloud_id = "b1gg2hr8eb22j7ht320k"
  folder_id = "b1g4h7anelqa7bko9vvb"
}
