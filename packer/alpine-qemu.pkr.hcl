packer {
  required_plugins {
    qemu = {
      version = "~> 1"
      source  = "github.com/hashicorp/qemu"
    }
  }
}

variable "alpine_version" {
  type    = string
  default = "3.21"
}

variable "alpine_patch" {
  type    = string
  default = "0"
}

variable "alpine_mirror" {
  type    = string
  default = "https://dl-cdn.alpinelinux.org/alpine"
}

locals {
  image_name = "generic_alpine-${var.alpine_version}.${var.alpine_patch}-x86_64-bios-cloudinit-r0.qcow2"
}

source "qemu" "alpine" {
  iso_url          = "${var.alpine_mirror}/v${var.alpine_version}/releases/cloud/${local.image_name}"
  iso_checksum     = "file:${var.alpine_mirror}/v${var.alpine_version}/releases/cloud/${local.image_name}.sha512"
  disk_image       = true
  output_directory = "output"
  vm_name          = "alpine-${var.alpine_version}.qcow2"
  format           = "qcow2"
  accelerator      = "none"
  disk_size        = "1G"
  memory           = 512
  cpus             = 2
  headless         = true

  communicator = "ssh"
  ssh_username = "root"
  ssh_password = "packer"
  ssh_timeout  = "10m"

  cd_files = ["cloud-init/*"]
  cd_label = "cidata"

  boot_wait        = "60s"
  shutdown_command  = "poweroff"

  qemuargs = [
    ["-serial", "stdio"],
    ["-display", "none"],
  ]
}

build {
  sources = ["source.qemu.alpine"]

  provisioner "file" {
    source      = "files/motd"
    destination = "/etc/motd"
  }

  provisioner "shell" {
    inline = [
      "grep k0rdent /etc/motd",
      "echo 'Build complete'",
    ]
  }
}
