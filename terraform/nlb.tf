resource "yandex_resourcemanager_folder_iam_member" "load-balancer-editor" {
  folder_id = var.folder_id
  role      = "load-balancer.editor"
  member    = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
}

resource "yandex_lb_network_load_balancer" "nlb-1" {
  name = "network-load-balancer-1"

  listener {
    name = "network-load-balancer-1-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_compute_instance_group.lamp-group.load_balancer.0.target_group_id

    healthcheck {
      name = "http"
      interval = 2
      timeout = 1
      unhealthy_threshold = 2
      healthy_threshold = 5
      
      http_options {
        port = 80
        path = "/index.html"
      }
    }
  }
}
