variable "statuscake_api_token" {
  type        = string
}

variable check_interval{
  type    = number
  default = 300
}

variable confirmation{
  type    = number
  default = 3
}

variable trigger_rate{
  type    = number
  default = 10
}

variable timeout {
  type    = number
  default = 15
}