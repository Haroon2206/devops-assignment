resource "statuscake_contact_group" "operations_team" {
  name     = var.name
  ping_url = var.ping_url

  email_addresses = [
    var.email_addresses
  ]
}