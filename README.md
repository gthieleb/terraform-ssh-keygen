# About

Simple terraform module to create a ssh keypair and additionally saves it on the local filename.

The public key part can be used for other terraform modules or provider resources like `aws_key_pair` or `hcloud_ssh_key`.

(!): This module creates a private key that is not protected with a passphrase!

Run the following command to set a passphrase for the key afterwards:
```
ssh-keygen -p -f ~/.ssh/id_rsa_yourkey
```

# Examples

Generate a ssh-key pair:

```
module ssh_keypair {
  source = "gthieleb/terraform-ssh-keygen"
}
```

Generate ssh-key with ED25519 algorithm:

```
module ssh_ed25519_keypair {
  source = "gthieleb/terraform-ssh-keygen"
  ssh_key_type = "ED25519"
}
```

Generate the ssh-key pair and save the keypair to local files:

```
module ssh_keypair_locally_saved {
  source = "gthieleb/terraform-ssh-keygen"
  key_name = "mytest123"
  create_local_file = true
}
```

# Usage

Usage with kube-hcloud:

```
module ssh_keypair {
  source = "gthieleb/terraform-ssh-keygen"
  ssh_key_type = "ED25519"
}


module "kube-hetzner" {
  source = "kube-hetzner/kube-hetzner/hcloud"

  ssh_public_key = module.ssh_keypair.ssh_public_key
  ssh_private_key = module.ssh_keypair.ssh_private_key
 
  ...
}
```

Use with hcloud_ssh_key:
```
resource "hcloud_ssh_key" "default" {
  name       = "Terraform Example"
  public_key = module.ssh_keypair.public_key
}
```
