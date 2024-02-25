module example_ed25519_local_saved {
  source = "../../"
  ssh_key_type = "ED25519"
  create_local_file = true
}

module example_rsa_not_saved_custom_bitsize {
  source = "../../"
  ssh_key_type = "RSA"
  ssh_rsa_bits = 512
  create_local_file = false
}

module example_rsa_custom_name_local_saved {
  source = "../../"
  ssh_key_name = "mykeyname"
  ssh_key_type = "RSA"
  create_local_file = true
}
