variable ssh_key_type {
  type = string
  description = "Currently-supported values are: RSA, ECDSA, ED25519"
  default = "RSA"
}

variable ssh_rsa_bits {
  type = number
  default = 4096
}

variable ssh_key_name {
  type = string
  default = ""
}

variable ssh_parent_path {
  type = string
  default = ""
  description = "Parent path where the ssh files are saved!"
}

variable create_local_file {
  type = bool
  default = false
}
