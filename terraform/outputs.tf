output "Picture_URL" {
  value = "https://${yandex_storage_bucket.s3-bucket.bucket_domain_name}/${yandex_storage_object.cat-picture.key}"
  description = "Адрес загруженной в бакет картинки"
}

output "group_vms" {
  value = [
    for instance in yandex_compute_instance_group.lamp-group.instances : {
      name = instance.name
      ip_internal = instance.network_interface[0].ip_address
      ip_external = instance.network_interface[0].nat_ip_address}
  ]
}

output "Network_Load_Balancer_Address" {
  value = yandex_lb_network_load_balancer.nlb-1.listener.*.external_address_spec[0].*.address
  description = "Адрес сетевого балансировщика"
}

# output "Application_Load_Balancer_Address" {
#   value = yandex_alb_load_balancer.application-balancer.listener.*.endpoint[0].*.address[0].*.external_ipv4_address
#   description = "Адрес L7-балансировщика"
# }
