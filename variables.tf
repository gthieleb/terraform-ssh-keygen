variable  key_name {
  type = string
}

variable  key_type {
  type = string
  description = "Currently-supported values are: RSA, ECDSA, ED25519"
  default = "RSA"
}

variable rsa_bits {
  type = number
  default = 4096
}

variable create_local_file {
  type = bool
  default = false
}
