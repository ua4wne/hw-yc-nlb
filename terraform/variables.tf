variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "bucket_name" {
  type        = string
  default     = "site-bucket"
  description = "S3 backet name"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "web-develop"
  description = "VPC network&subnet name"
}

variable "public_subnet" {
  type        = string
  default     = "public-subnet"
  description = "subnet name"
}

variable "resources_vm" {
  type = map(any)
  default = {
    cores         = 2
    memory        = 2
    core_fraction = 5
    disk_size     = 10
    disk_type     = "network-ssd"
  }
}

variable "vm_platform" {
  type        = string
  default     = "standard-v1"
  description = "platform of compute instanse"
}

variable "vm_preemptible" {
  type        = bool
  default     = true
  description = "preemptible"
}

variable "vm_nat" {
  type        = bool
  default     = true
  description = "nat enable"
}

variable "vm_user" {
  type        = string
  default     = "ubuntu"
  description = "default user"
}

# Lamp
variable "lamp-instance-image-id" {
  default = "fd827b91d99psvq5fjit"
}

variable "metadata_map" {
  type = map(object({
    serial-port-enable = bool
    ssh-keys           = string
  }))
  default = {
    metadata = {
      serial-port-enable = true
      ssh-keys           = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIdGeVIrjr+DNhhCOKPA5Rl3Aui+Kwk8N3GHiUYs2H+F dervish@devops"
    }
  }
}
