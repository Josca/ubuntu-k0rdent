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
  ssh_timeout  = "20m"

  http_directory = "http"

  boot_wait = "60s"
  boot_command = [
    "root<enter><wait10>",
    "ifconfig eth0 up && udhcpc -i eth0<enter><wait10>",
    "wget http://{{ .HTTPIP }}:{{ .HTTPPort }}/answers -O /tmp/answers<enter><wait5>",
    "setup-alpine -f /tmp/answers<enter><wait5>",
    "packer<enter><wait>",
    "packer<enter><wait60>",
    "mount /dev/vda3 /mnt<enter><wait>",
    "echo 'PermitRootLogin yes' >> /mnt/etc/ssh/sshd_config<enter>",
    "umount /mnt<enter><wait>",
    "reboot<enter><wait90>",
    "root<enter><wait5>",
    "packer<enter><wait10>",
  ]

  shutdown_command = "poweroff"

  qemuargs = [
    ["-m", "512M"],
  ]
}

build {
  sources = ["source.qemu.alpine"]

  # Custom MOTD
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
