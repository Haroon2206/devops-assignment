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

resource "statuscake_uptime_check" "example" {
  check_interval = 300
  confirmation   = 3
  name           = "VG website Status Up Check"
  trigger_rate   = 10

  http_check {
    timeout          = 15
    validate_ssl     = true
    status_codes = [
      "200"
    ]
  }

  monitored_resource {
    address = "https://www.vg.no"
  }
  tags = [
    "production",
  ]
}

resource "statuscake_contact_group" "operations_team" {
  name     = "Operations Team"
  ping_url = "https://www.vg.no"

  email_addresses = [
    "Haroon@live.no"
  ]
}

output "example_com_uptime_check_id" {
  value = statuscake_uptime_check.example.id
}