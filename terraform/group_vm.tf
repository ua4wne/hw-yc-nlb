resource "yandex_iam_service_account" "ig-sa" {
  name        = "ig-sa"
  description = "Сервисный аккаунт для управления группой ВМ."
}

resource "yandex_resourcemanager_folder_iam_member" "compute-editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
  depends_on = [
    yandex_iam_service_account.ig-sa,
  ]
}

resource "yandex_compute_instance_group" "lamp-group" {
  name               = "lamp-group-with-balancer"
  folder_id          = var.folder_id
  service_account_id = yandex_iam_service_account.ig-sa.id
  depends_on         = [yandex_resourcemanager_folder_iam_member.compute-editor]
  instance_template {
    platform_id = var.vm_platform
    resources {
      cores         = var.resources_vm["cores"]
      memory        = var.resources_vm["memory"]
      core_fraction = var.resources_vm["core_fraction"]
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = var.lamp-instance-image-id
        size     = var.resources_vm["disk_size"]
        type     = var.resources_vm["disk_type"]
      }
    }

    network_interface {
      network_id = yandex_vpc_network.develop.id
      subnet_ids = ["${yandex_vpc_subnet.public.id}"]
      nat        = var.vm_nat
    }

    scheduling_policy {
      preemptible = var.vm_preemptible
    }

    metadata = {
      serial-port-enable = var.metadata_map.metadata.serial-port-enable
      ssh-keys           = "${var.vm_user}:${var.metadata_map.metadata.ssh-keys}"
      user-data          = <<EOF
#!/bin/bash
apt install httpd -y
cd /var/www/html
echo '<html><head><title>Space</title></head> <body><h1>Hello World!</h1><img src="http://${yandex_storage_bucket.s3-bucket.bucket_domain_name}/space.png"/></body></html>' > index.html
service httpd start
EOF
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = [var.default_zone]
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 0
    max_creating     = 3
    max_deleting     = 1
    startup_duration = 3
  }

  health_check {
    interval = 30
    timeout  = 10
    tcp_options {
      port = 80
    }
  }

  load_balancer {
    target_group_name        = "target-group-lamp"
    target_group_description = "Целевая группа Network Load Balancer"
  }
}
