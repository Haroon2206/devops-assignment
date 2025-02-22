resource "statuscake_uptime_check" "StatusCheck" {
  check_interval = var.check_interval
  confirmation   = var.confirmation
  name           = var.name
  trigger_rate   = var.trigger_rate

  http_check {
    timeout      = var.timeout
    validate_ssl = var.validate_ssl
    status_codes = var.status_codes
  }

  monitored_resource {
    address = var.address
  }

  tags = var.tags
}
