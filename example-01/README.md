== Basics

terraform init
terraform init -upgrade

terraform plan

terraform apply

terraform show

sudo apt install graphviz

terraform graph > test.dot
dot test.dot -Tsvg -o test.svg
dot test.dot -Tpng -o test.png

terraform destroy

init script:

export DEBIAN_FRONTEND=noninteractive; apt-get update -y && apt-get upgrade -y

; reboot

== Example 1
- 1 node

== Example 2
- extended example 1 - count = 3 - dynamic node name

-------------- Provisioning
https://www.terraform.io/language/resources/provisioners/syntax

== Example 3
- Ansible provisioning node-by-node
provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u {var.user} -i '${self.ipv4_address},' --private-key ${var.ssh_private_key} playbook.yml"}

== Example 4
- Dynamic Ansible Inventory
provisioner "local-exec" {
    command = "ansible-playbook -i dynamic_inventory ansible-provision.yml
}

== Example 5
- Docker

== Example 6
- Docker Compose

== Example 7
- Kubernetes

== Information resources
https://medium.com/geekculture/the-most-simplified-integration-of-ansible-and-terraform-49f130b9fc8
