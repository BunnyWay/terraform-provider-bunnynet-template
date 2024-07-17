terraform {
  required_providers {
    bunnynet = {
      source = "BunnyWay/bunnynet"
    }
  }
}

provider "bunnynet" {
  api_key = "00000000-0000-0000-0000-000000000000"
}

provider "random" {
}
