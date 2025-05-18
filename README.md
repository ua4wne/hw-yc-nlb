# Задание 1. Yandex Cloud

## 1. Создать бакет Object Storage и разместить в нём файл с картинкой:

    Создать бакет в Object Storage с произвольным именем (например, имя_студента_дата).
    Положить в бакет файл с картинкой.
    Сделать файл доступным из интернета.

>[s3.tf](./terraform/s3.tf)

![s3.png](./task1/s3.png)
![yc-backet.png](./task1/yc-backet.png)
![upload.png](./task1/upload.png)


## 2. Создать группу ВМ в public подсети фиксированного размера с шаблоном LAMP и веб-страницей, содержащей ссылку на картинку из бакета:

    Создать Instance Group с тремя ВМ и шаблоном LAMP. Для LAMP рекомендуется использовать image_id = fd827b91d99psvq5fjit.
    Для создания стартовой веб-страницы рекомендуется использовать раздел user_data в meta_data.
    Разместить в стартовой веб-странице шаблонной ВМ ссылку на картинку из бакета.
    Настроить проверку состояния ВМ.

>[group_vm.tf](./terraform/group_vm.tf)

![group-vm.png](./task1/group-vm.png)
![all-vm.png](./task1/all-vm.png)

## 3. Подключить группу к сетевому балансировщику:

    Создать сетевой балансировщик.
    Проверить работоспособность, удалив одну или несколько ВМ.

>[nlb.tf](./terraform/nlb.tf)

![nlb-deploy.png](./task1/nlb-deploy.png)
![nlb.png](./task1/nlb.png)
![site.png](./task1/site.png)

>Остановим две машины из трех и проверим работоспособность сайта

![stop-vm.png](./task1/stop-vm.png)

>Как видим, сайт работает!

![site.png](./task1/site.png)


## 4. (дополнительно)* Создать Application Load Balancer с использованием Instance group и проверкой состояния.

>[l7_target_group.tf](./terraform/l7_target_group.tf)

>[l7_lb.tf](./terraform/l7_lb.tf)

>[l7_http_router.tf](./terraform/l7_http_router.tf)

>[l7_backend.tf](./terraform/l7_backend.tf)

![l7-deploy.png](./task1/l7-deploy.png)
![l7-abl.png](./task1/l7-abl.png)
![http-router.png](./task1/http-router.png)
![l7-backend.png](./task1/l7-backend.png)
![l7-tg.png](./task1/l7-tg.png)
![l7-site.png](./task1/l7-site.png)
