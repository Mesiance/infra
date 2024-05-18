###
resource "serverspace_ssh" "terraform_ssh_key" {
  name = "terraform_ssh_key"
  public_key = var.ssh_public_key
}

resource "serverspace_isolated_network" "kubernetes_vm_network" {
  location = var.region
  name = "kubernetes_vm_network"
  description = "Isolated internal network for k8s machines"
  network_prefix = var.network_subnet_cidr
  mask = var.network_subnet_mask
}

resource "serverspace_server" "k8s_hosts" {
  count = 1
  image = var.os_image
  name = "k8s-host-${count.index + 1}"
  location = var.region
  cpu = var.cpu_count
  ram = var.memory_count
  boot_volume_size = var.disk_size*1024

  # Add public interface for the firt host(master, ingress)
  dynamic "nic" {
    for_each = count.index == 0 ? ["PublicShared"] : []
    content {
      network = ""
      network_type = nic.value
      bandwidth = var.publc_vm_network_bandwidth
    }
  }

  nic {
    network = resource.serverspace_isolated_network.kubernetes_vm_network.id
    network_type = "Isolated"
    bandwidth = 0
  }

  ssh_keys = [
    resource.serverspace_ssh.terraform_ssh_key.id,
  ]
}

resource "null_resource" "change_ssh_config" {
  count = length(
    [for nic in serverspace_server.k8s_hosts[0].nic : nic if nic.network_type == "PublicShared"]
  ) > 0 ? 1 : 0

  connection {
    host = serverspace_server.k8s_hosts[0].public_ip_addresses[0]
    user = "root"
    type = "ssh"
    agent = false
    private_key = file(var.ssh_private_key_path)
    timeout = "2m"
  }

  provisioner "file" {
    content = templatefile(
      "./templates/sshd_config.tftpl",
      {
        port = var.ssh_new_port, 
        permit_root_login = var.ssh_permit_root_login
      }
    )
    destination = "/etc/ssh/sshd_config"
  }

  provisioner "remote-exec" {
    inline = [
      "systemctl restart sshd"
    ]
  }
}