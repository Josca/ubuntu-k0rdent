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

variable "alpine_mirror" {
  type    = string
  default = "https://dl-cdn.alpinelinux.org/alpine"
}

source "qemu" "alpine" {
  iso_url          = "${var.alpine_mirror}/v${var.alpine_version}/releases/x86_64/alpine-virt-${var.alpine_version}.0-x86_64.iso"
  iso_checksum     = "file:${var.alpine_mirror}/v${var.alpine_version}/releases/x86_64/alpine-virt-${var.alpine_version}.0-x86_64.iso.sha256"
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

  boot_wait = "30s"
  boot_command = [
    "root<enter><wait>",
    "ifconfig eth0 up && udhcpc -i eth0<enter><wait5>",
    "setup-apkrepos -1<enter><wait5>",
    "echo 'root:packer' | chpasswd<enter><wait>",
    "echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config<enter>",
    "mkdir -p /run/openrc && touch /run/openrc/softlevel<enter>",
    "rc-service sshd start<enter><wait5>",
  ]

  shutdown_command = "poweroff"

  qemuargs = [
    ["-m", "512M"],
  ]
}

build {
  sources = ["source.qemu.alpine"]

  # Install to disk so the image is persistent
  provisioner "shell" {
    inline = [
      "export ERASE_DISKS=/dev/vda",
      "echo -e 'us\nus\nalpine\neth0\ndhcp\ndone\nnone\nno\nvda\nsys\ny' | setup-alpine || true",
    ]
  }

  # Custom MOTD
  provisioner "file" {
    source      = "files/motd"
    destination = "/mnt/etc/motd"
  }

  provisioner "shell" {
    inline = [
      "cat /mnt/etc/motd",
      "echo 'Build complete'",
    ]
  }
}
