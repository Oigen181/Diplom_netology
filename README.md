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


Установку осуществлял с помощью этого сайта где приведены все команды для устанвки как Прометуса и Графаны, а также сторонних ресурсов в настройке файлов конфигураций, в том числе и презентаций Нетологии.
https://losst.pro/ustanovka-i-nastrojka-prometheus?ysclid=lq3sjayvoo845126530

Ниже приведены скриншоты установки систем мониторинга

![Скриншот 07-12-2023 163606](https://github.com/Oigen181/Diplom_netology/assets/126493876/c5cc70a1-66d6-42e0-95b2-6cb352d8b1aa)

![Скриншот 07-12-2023 163829](https://github.com/Oigen181/Diplom_netology/assets/126493876/a1ab3fe8-6dcd-4dbb-8587-915a42de1c8f)

![Скриншот 07-12-2023 164716](https://github.com/Oigen181/Diplom_netology/assets/126493876/bc8a6c7d-e455-4c7e-ac99-e025c7075b6e)

![Скриншот 07-12-2023 164407](https://github.com/Oigen181/Diplom_netology/assets/126493876/7148a353-7b71-4870-8356-4f036380a046)


Также ставим на наши веб сервера prometheus-nginxlog-exporter 

![Скриншот 07-12-2023 165724](https://github.com/Oigen181/Diplom_netology/assets/126493876/d41d2037-bb92-4d15-bc03-860393c3880b)

![Скриншот 07-12-2023 165846](https://github.com/Oigen181/Diplom_netology/assets/126493876/47c4cd04-b556-451f-9a0b-a43ee137823a)

Проверяем и заходим по внешнему ip адресу на Prometheus.


![Скриншот 07-12-2023 165911](https://github.com/Oigen181/Diplom_netology/assets/126493876/0ece1893-99e8-4589-bfbb-10f0ac4633ec

Установка Графаны и настройка дашборда согласно условиям

![Скриншот 07-12-2023 170629](https://github.com/Oigen181/Diplom_netology/assets/126493876/2c8e0736-fa90-4de6-a949-1bd8dc288e5f)

Проверяем доступность наших серверов и загружаем готовый дашборд как раз для наших нужд


![Скриншот 07-12-2023 220514](https://github.com/Oigen181/Diplom_netology/assets/126493876/ed17b232-9fad-4887-9ff2-d787568d15ee)


![Скриншот 07-12-2023 220545](https://github.com/Oigen181/Diplom_netology/assets/126493876/73ccf4eb-07a7-4a24-b051-609cb3b028a4)

---

### 3. Логи

---

Установка Kibana и Elasticsearch

Самое проблематичное это установка Elasticsearch, но мне помог этот ресурс:
https://itobereg.ru/services/install-elasticsearch?ysclid=lq3ts20q98643535193
C Kibana примерно тоже самое.



![Скриншот 07-12-2023 193742](https://github.com/Oigen181/Diplom_netology/assets/126493876/25dfa32d-6695-4072-9bf3-963452f6f045)



![Скриншот 07-12-2023 194344](https://github.com/Oigen181/Diplom_netology/assets/126493876/099f9c8a-1208-4120-9f5f-8d85df742e54)


![Скриншот 07-12-2023 194739](https://github.com/Oigen181/Diplom_netology/assets/126493876/3fe502ef-8e54-4182-96ac-35c4876dd44c)


Подключаемся и проверяем подключение к Elasticsearch

![Скриншот 07-12-2023 201504](https://github.com/Oigen181/Diplom_netology/assets/126493876/3c485f4c-4a7b-4c26-ae99-bf2615427c5b)



![Скриншот 07-12-2023 201600](https://github.com/Oigen181/Diplom_netology/assets/126493876/9134b392-714d-4e8d-8b53-988254c7ce53)
