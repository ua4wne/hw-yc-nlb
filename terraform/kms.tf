resource "yandex_resourcemanager_folder_iam_member" "sa-kms" {
  folder_id = var.folder_id
  role      = "kms.keys.encrypterDecrypter"
  member    = "serviceAccount:${yandex_iam_service_account.service.id}"
}

resource "yandex_kms_symmetric_key" "secret-key" {
  name              = "s3-key"
  description       = "ключ для шифрования S3 бакета"
  default_algorithm = "AES_128"
  rotation_period   = "24h"
}
