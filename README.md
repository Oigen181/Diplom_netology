# Дипломная работа по профессии «`Системный администратор`» Андреев Евгений

==========

### Решение

---

### 1. Создание чистой инфраструктуры и настройка Nginx на web сервера

---

Для решения данной задачи использовал Ubuntu 22.04. Первым делом создаем файл main.tf для terraform с созданием всех условий для данной задачи.


На данном скриншоте представлен итог создания чистой инфраструктуры - 6 ВМ и балансировщика.

![Скриншот 14-11-2023 171121](https://github.com/Oigen181/Diplom_netology/assets/126493876/d050b939-84cd-4d7c-b770-53b4b725541c)

![Скриншот 14-11-2023 170928](https://github.com/Oigen181/Diplom_netology/assets/126493876/2549944c-ca21-4b1b-9e87-71c3d6714ce8)

![Скриншот 14-11-2023 170941](https://github.com/Oigen181/Diplom_netology/assets/126493876/4ca4349b-83d2-40d0-82f7-1e6fb1c7bde3)

После создания всех ВМ используем Ansible последней версии для установки на Web сервера nginx. Предварительно настроив кофигурационный файл ansible.cfg, окружение inventory.ini, файл hosts и непосредственно playbook для развертования nginx.

Перед началом запуска плейбука тестируем подключение ansible all -m ping 

![Скриншот 13-12-2023 154906](https://github.com/Oigen181/Diplom_netology/assets/126493876/aeaab6e5-fee2-400b-82ef-df02e37a394e)

После мы установливаем плейбук на на наши web сервера vm-1 and vm-2

Производим тест по внешнему ip адресу балансировщика через команду curl -v 

![Скриншот 07-12-2023 161112](https://github.com/Oigen181/Diplom_netology/assets/126493876/7f5445fe-a155-4bf0-a845-091a7f24600f)

---

### 2. Мониторинг по средствам Prometheus и Grafana

----

Для установки Prometheus, а также Node Exporter и Nginx Log Exporter и Grafana на ранее созданные ВМ я использовал вариант подключения к машинам напрямую через SSH, а не через Ansivble. Так как этот вариант мне показался ближе и менее запутаным. 
В дальнейшем установка по средствам подключения по SSH я буду использовать для всех ВМ.


Установку осуществлял с помощью этого сайта где приведены все команды для устанвки как Прометуса и Графаны 
https://losst.pro/ustanovka-i-nastrojka-prometheus?ysclid=lq3sjayvoo845126530

