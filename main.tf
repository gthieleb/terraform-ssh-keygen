locals {

  ssh_key_sfx = "id_${lower(var.ssh_key_type)}"
  ssh_key_name = var.ssh_key_name != "" ? "${var.ssh_key_name}-${local.ssh_key_sfx}" : "terraform-${basename(abspath(path.root))}-${random_integer.key_id.result}-${local.ssh_key_sfx}"
  ssh_parent_path = var.ssh_parent_path != "" ? var.ssh_parent_path : pathexpand("~/.ssh")
  ssh_public_key_path = join("/", [local.ssh_parent_path, "${local.ssh_key_name}.pub"])
  ssh_private_key_path = join("/", [local.ssh_parent_path, local.ssh_key_name])

  rsa_bits = var.ssh_key_type != "RSA" ? null : var.ssh_rsa_bits


}

resource "random_integer" "key_id" {
  min = 11111
  max = 99999
}

resource "tls_private_key" "generated" {
  algorithm = var.ssh_key_type
  rsa_bits  = local.rsa_bits
}

resource local_file private_key_file { 

  count = var.create_local_file ? 1 : 0

  content = tls_private_key.generated.private_key_openssh
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
  value     = tls_private_key.generated.private_key_openssh
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


