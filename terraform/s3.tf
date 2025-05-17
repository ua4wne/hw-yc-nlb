resource "random_string" "unique_id" {
  length  = 8
  upper   = false
  lower   = true
  numeric = true
  special = false
}

// Создаем сервисный аккаунт для backet
resource "yandex_iam_service_account" "service" {
  folder_id = var.folder_id
  name      = "sa-bucket"
  description = "sa for backet operations"
}

// Назначение роли сервисному аккаунту
resource "yandex_resourcemanager_folder_iam_member" "bucket-editor" {
  folder_id   = var.folder_id
  role        = "storage.admin"
  member      = "serviceAccount:${yandex_iam_service_account.service.id}"
  depends_on = [yandex_iam_service_account.service]
}

// Создание статического ключа доступа
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.service.id
  description        = "static access key for object storage"
  depends_on = [yandex_iam_service_account.service]
}

// Создание бакета с использованием ключа
resource "yandex_storage_bucket" "s3-bucket" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket = "${var.bucket_name}-${random_string.unique_id.result}"
  acl    = "public-read"
  depends_on = [yandex_iam_service_account_static_access_key.sa-static-key]
}

// Add picture to bucket
resource "yandex_storage_object" "cat-picture" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket = "${var.bucket_name}-${random_string.unique_id.result}"
  key    = "space.png"
  source = "./space.png"
  acl = "public-read"
  depends_on = [yandex_storage_bucket.s3-bucket]
}