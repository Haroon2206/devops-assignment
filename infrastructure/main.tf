terraform {
  required_providers {
    statuscake = {
      source = "StatusCakeDev/statuscake"
      version = "2.2.2"
    }
  }
}

provider "statuscake" {
  api_token = var.statuscake_api_token
}

module "statuscake_uptime_vg" {
  source         = "./modules/statuscake_uptime"
  check_interval = var.check_interval
  confirmation   = var.confirmation
  name           = "VG website Status Up Check"
  trigger_rate   = var.trigger_rate
  timeout        = var.timeout
  validate_ssl   = true
  status_codes   = ["200"]
  address        = "https://www.vg.no"
  tags           = ["production"]
}

module "statuscake_uptime_xkcd" {
  source         = "./modules/statuscake_uptime"
  check_interval = var.check_interval
  confirmation   = var.confirmation
  name           = "xkcd website Status Up Check"
  trigger_rate   = var.trigger_rate
  timeout        = var.timeout
  validate_ssl   = true
  status_codes   = ["200"]
  address        = "https://xkcd.com"
  tags           = ["development"]
}

module "statuscake_contact_group"{
source = "./modules/contact_group"
name= "Monitoring Team"
ping_url= "https://xkcd.com"
email_addresses="haroon@live.no"
}