locals {
  ssh_key_name = var.ssh_key_name != "" ? var.ssh_key_name : "id_rsa_terraform"
  ssh_parent_path = var.ssh_parent_path != "" ? var.ssh_parent_path : pathexpand("~/.ssh")
  ssh_public_key_path = join("/", [local.ssh_parent_path, "${var.ssh_key_name}.pub"])
  ssh_private_key_path = join("/", [local.ssh_parent_path, "${var.ssh_key_name}"])

  rsa_bits = var.key_type != "RSA" ? null : var.rsa_bits

}

resource "tls_private_key" "generated" {
  algorithm = var.key_type
  rsa_bits  = local.rsa_bits
}

resource local_file private_key_file { 

  count = var.create_local_file ? 1 : 0

  content = tls_private_key.generated.private_key_pem
  directory_permission = "0700"
  file_permission = "0600"
  filename = local.ssh_private_key_path
}

resource local_file public_key_file_openssh { 

  count = var.create_local_file ? 1 : 0

  content = tls_private_key.generated.public_key_openssh
  directory_permission = "0700"
  file_permission = "0600"
  filename = local.ssh_public_key_path
}

output "ssh_private_key" {
  value     = tls_private_key.generated.private_key_pem
  sensitive = true
}

output "ssh_public_key" {
  value     = tls_private_key.generated.public_key_openssh
  sensitive = true
}

output "ssh_private_key_path" {
  value = local.ssh_private_key_path
}

output "ssh_public_key_path" {
  value = local.ssh_public_key_path
}


