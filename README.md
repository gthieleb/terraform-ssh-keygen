# About

This terraform module creates a ssh keypair and additionally saves it on the local filename.

The public key part can be used for other terraform modules or provider resources like `aws_key_pair` or `hcloud_ssh_key`.

Caution: This module creates a private key that is not protected with a passphrase!

Run the following command to set a passphrase for the key afterwards:
```
ssh-keygen -p -f ~/.ssh/id_rsa_yourkey
```

# Example

Generate the ssh-key pair without saving it to a file:
```
module example {
  source = "../../"
  key_name = "mytest123"
}
```

Generate the ssh-key pair and save it to a file:
```
module example {
  source = "../../"
  key_name = "mytest123"
  create_local_file = true
}
```

# Usage

Use with hcloud_ssh_key:
```
resource "hcloud_ssh_key" "default" {
  name       = "Terraform Example"
  public_key = module.example.public_key
}
```
