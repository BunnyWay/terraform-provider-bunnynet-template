resource "random_string" "name" {
  length = 8
  special = false
  upper = false
}

resource "bunnynet_storage_zone" "template" {
  name = "terraform-template-${random_string.name.result}"
  zone_tier = "Edge"
  region = "DE"
  replication_regions = ["NY", "SYD"]
}

resource "bunnynet_storage_file" "homepage" {
  zone = bunnynet_storage_zone.template.id
  path = "index.html"
  content = "<h1>Hello world</h1><p>Greetings from Terraform via <a href=\"https://${bunnynet_pullzone.template.name}.${bunnynet_pullzone.template.cdn_domain}\">${bunnynet_pullzone.template.name}.${bunnynet_pullzone.template.cdn_domain}</a></p>"
}

resource "bunnynet_pullzone" "template" {
  name = bunnynet_storage_zone.template.name

  origin {
    type = "StorageZone"
    storagezone = bunnynet_storage_zone.template.id
  }

  routing {
    tier = "Standard"
  }
}

output "url" {
    value = "https://${bunnynet_pullzone.template.name}.${bunnynet_pullzone.template.cdn_domain}"
}
