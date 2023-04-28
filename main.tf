locals {
  ssh_parent_path = pathexpand("~/.ssh")
}

resource "tls_private_key" "generated" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource local_file private_key_file { 

  count = var.create_local_file ? 1 : 0

  content = tls_private_key.generated.private_key_pem
  directory_permission = "0700"
  file_permission = "0600"
  filename = join("/", [local.ssh_parent_path, "id_rsa_${var.key_name}"])
}

resource local_file public_key_file { 

  count = var.create_local_file ? 1 : 0

  content = tls_private_key.generated.public_key_pem
  directory_permission = "0700"
  file_permission = "0600"
  filename = join("/", [local.ssh_parent_path,"authorized_keys_${var.key_name}"])
}

output "private_key" {
  value     = tls_private_key.generated.private_key_pem
  sensitive = true
}

output "public_key" {
  value     = tls_private_key.generated.private_key_pem
  sensitive = true
}
