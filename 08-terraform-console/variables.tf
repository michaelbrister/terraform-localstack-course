variable "env" {
  type    = string
  default = "dev"
}

variable "prefix" {
  type    = string
  default = "tf-course"
}

variable "optional_name" {
  type    = string
  default = null
}

variable "tag_overrides" {
  type    = map(string)
  default = {}
}

variable "maybe" {
  type    = any
  default = { present = "yes" }
}

variable "subnets" {
  type = list(object({
    name = string
    cidr = string
    az   = string
    type = string
  }))
}
