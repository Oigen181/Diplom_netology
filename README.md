# Дипломная работа по профессии «`Системный администратор`» Андреев Евгений.

============================================================================================

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

![Скриншот 07-12-2023 165911](https://github.com/Oigen181/Diplom_netology/assets/126493876/a4848b8c-9ee1-4dae-ad0f-148a6f6d77bf)


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
C Kibana и Filebit примерно тоже самое.



![Скриншот 07-12-2023 193742](https://github.com/Oigen181/Diplom_netology/assets/126493876/25dfa32d-6695-4072-9bf3-963452f6f045)



![Скриншот 07-12-2023 194344](https://github.com/Oigen181/Diplom_netology/assets/126493876/099f9c8a-1208-4120-9f5f-8d85df742e54)


![Скриншот 07-12-2023 194739](https://github.com/Oigen181/Diplom_netology/assets/126493876/3fe502ef-8e54-4182-96ac-35c4876dd44c)


Подключаемся и проверяем подключение к Elasticsearch

![Скриншот 07-12-2023 201504](https://github.com/Oigen181/Diplom_netology/assets/126493876/3c485f4c-4a7b-4c26-ae99-bf2615427c5b)



![Скриншот 07-12-2023 201600](https://github.com/Oigen181/Diplom_netology/assets/126493876/9134b392-714d-4e8d-8b53-988254c7ce53)

Установка Filebit


![Скриншот 07-12-2023 202453](https://github.com/Oigen181/Diplom_netology/assets/126493876/3affd608-0d8c-48ed-b54f-bd3375352963)

Переходим по внешнему ip и проверяем логи по нашим серверам 

![Скриншот 07-12-2023 204422](https://github.com/Oigen181/Diplom_netology/assets/126493876/a5af07d5-6b39-4560-866d-aedb0abfff66)


![Скриншот 07-12-2023 204447](https://github.com/Oigen181/Diplom_netology/assets/126493876/d4fdc5b7-f01a-4e49-827a-aede8629394b)

---

### 4.Сеть

---

Настройка групп безоапасности согласно заданным условиям. Изначально это можно было задать через terraform, но очень хотелось попользоваться интерфейсом Yandex cloud.

Подключение по SSH: 

![Скриншот 11-12-2023 173032](https://github.com/Oigen181/Diplom_netology/assets/126493876/c6920f41-73a5-4b2a-9ed8-a8f6e7f0d075)


![Скриншот 11-12-2023 173040](https://github.com/Oigen181/Diplom_netology/assets/126493876/15c17642-628f-4893-8a24-89f237e28760)

Подключение Private group 

![Скриншот 11-12-2023 173005](https://github.com/Oigen181/Diplom_netology/assets/126493876/2e5168a1-3600-4e88-9b07-0faa322c4475)


![Скриншот 11-12-2023 173017](https://github.com/Oigen181/Diplom_netology/assets/126493876/151a10be-a735-4cc8-8ac2-c7a41d032252)

Подключение Public group

![Скриншот 11-12-2023 173103](https://github.com/Oigen181/Diplom_netology/assets/126493876/ad7b373f-e4f1-4a9b-b370-73afa9e3f1df)


![Скриншот 11-12-2023 173055](https://github.com/Oigen181/Diplom_netology/assets/126493876/8b89d38a-57e2-434b-99fb-f2391fd374fe)

---

### 5. Резервное копирование

--- 

Создание снимков расписания:


![Скриншот 11-12-2023 173741](https://github.com/Oigen181/Diplom_netology/assets/126493876/f45f4635-f31e-4ffa-a0d2-f13021360990)


![Скриншот 11-12-2023 173756](https://github.com/Oigen181/Diplom_netology/assets/126493876/6990b82a-7673-42ec-a047-39b12589c094)

---

### 6. Заключение

----

Не скажу, что работа была легкой, приходилось очень много искать ошибок в процессе построения и развертования инфраструктуры. На самом деле ресурсов очень много и могут завести не туда, но наверно в том и заключается работа системного администратора уметь разбираться в огромном потоке информации и правильно принимать решения. Ip адреса могут отличаться на скриншотах т.к я очень много раз разворачивал и где то забвывал делать скриншоты о проделанной работе.
Спасибо Нетологии за обучение!


