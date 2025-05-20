# Задание 1. Yandex Cloud

## 1. С помощью ключа в KMS необходимо зашифровать содержимое бакета:

    создать ключ в KMS;
    с помощью ключа зашифровать содержимое бакета, созданного ранее.

>Воспользуемся кодом из предыдущего ДЗ, оставив только работу с бакетом.

>[kms.tf](./terraform/kms.tf)

>[s3.tf](./terraform/s3.tf)

![s3.png](./task1/s3.png)
![upload.png](./task1/upload.png)
![kms.png](./task1/kms.png)
![picture.png](./task1/picture.png)
![result.png](./task1/result.png)


## 2. (Выполняется не в Terraform)* Создать статический сайт в Object Storage c собственным публичным адресом и сделать доступным по HTTPS:

    создать сертификат;
    создать статическую страницу в Object Storage и применить сертификат HTTPS;
    в качестве результата предоставить скриншот на страницу с сертификатом в заголовке (замочек).

![cert.png](./task1/cert.png)
![validate.png](./task1/validate.png)
![backet.png](./task1/backet.png)
![ssl.png](./task1/ssl.png)

