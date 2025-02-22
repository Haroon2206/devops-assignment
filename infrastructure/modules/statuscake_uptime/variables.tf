variable "check_interval"{
  type    = number
  default = 300
}

variable "confirmation"{
  type    = number
  default = 3
}

variable "trigger_rate"{
  type    = number
  default = 10
}

variable "timeout" {
  type    = number
  default = 15
}

variable "name" {
    type = string
}

variable "validate_ssl"{
type = bool
}

variable "status_codes" {
type    = list(number)
default = [200]
}

variable "tags" {
type = list(string)
default = ["development"]
}

variable "address"{
    type = string
}