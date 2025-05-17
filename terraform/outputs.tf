output "Picture_URL" {
  value = "https://${yandex_storage_bucket.s3-bucket.bucket_domain_name}/${yandex_storage_object.cat-picture.key}"
  description = "Адрес загруженной в бакет картинки"
}