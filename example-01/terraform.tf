
terraform {
  required_providers {
    opennebula = {
      source = "OpenNebula/opennebula"
      version = "0.4.3"
    }
  }
}

provider "opennebula" {
  endpoint      = "${var.one_endpoint}"
  username      = "${var.one_username}"
  password      = "${var.one_password}"
}

data "template_file" "cloudinit" {
  template = "${file("cloud-init.yaml")}"
}

resource "opennebula_image" "os-image" {
    name = "${var.vm_image_name}"
    datastore_id = "${var.vm_imagedatastore_id}"
    persistent = false
    path = "${var.vm_image_url}"
    permissions = "600"
}

resource "opennebula_virtual_machine" "test-master-vm" {
  # This will create 1 instances
  count = 1
  name = "terraform-test-master"
  description = "First testing VM"
  cpu = 1
  vcpu = 1
  memory = 1024
  permissions = "600"
  group = "users"

  context = {
    NETWORK      = "YES"
    HOSTNAME     = "$NAME"
    SSH_PUBLIC_KEY = "${var.vm_ssh_pubkey}"
    START_SCRIPT = "${var.vm_startup_script}"
    #START_SCRIPT_BASE64 = ""
  }
  os {
    arch = "x86_64"
    boot = "disk0"
  }
  disk {
    image_id = opennebula_image.os-image.id
    target   = "vda"
    size     = 16000 # 16GB
  }

  graphics {
    listen = "0.0.0.0"
    type   = "vnc"
  }

  nic {
    network_id = var.vm_network_id
  }
}

#-------OUTPUTS ------------

output "test-master-vm_id" {
  value = "${opennebula_virtual_machine.test-master-vm.*.ip}"
}
