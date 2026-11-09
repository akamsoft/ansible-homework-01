# Домашнее задание к занятию 1 «Введение в Ansible»

## Подготовка к выполнению

1. Установите Ansible версии 2.10 или выше.

![Alt text](images/1.jpg)
  
3. Создайте свой публичный репозиторий на GitHub с произвольным именем. 

Создан **публичный** репозиторий: `https://github.com/akamsoft/ansible-homework-01`.

4. Скачайте [Playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.

Playbook из [`netology-code/mnt-homeworks/08-ansible-01-base/playbook`](https://github.com/netology-code/mnt-homeworks/tree/MNT-video/08-ansible-01-base/playbook) скопирован в папку `playbook/` репозитория.

## Основная часть

1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте значение, которое имеет факт `some_fact` для указанного хоста при выполнении playbook.

### Пункт 1. Запуск playbook на `test.yml`

Инвентарь `playbook/inventory/test.yml`:

```yaml
---
  inside:
    hosts:
      localhost:
        ansible_connection: local
        ansible_python_interpreter: /usr/bin/python3
```

Команда:

```bash
cd playbook
ansible-playbook -i inventory/test.yml site.yml
```

Вывод задачи `Print fact`:

```
TASK [Print fact] ***
ok: [localhost] => {
    "msg": 12
}
```

**Зафиксированное значение `some_fact` для хоста `localhost`: `12`.**

Значение задаётся в `playbook/group_vars/all/examp.yml`. Переменные из `group_vars/el` и `group_vars/deb` к хосту не применяются, так как в `test.yml` хост входит только в группу `inside` (и неявно `all`).

![Alt text](images/2.jpg)

2. Найдите файл с переменными (group_vars), в котором задаётся найденное в первом пункте значение, и поменяйте его на `all default fact`.

Искомый файл — `playbook/group_vars/all/examp.yml`.

Было:

```yaml
---
  some_fact: 12
```

Стало:

```yaml
---
  some_fact: "all default fact"
```

![Alt text](images/3.jpg)

![Alt text](images/4.jpg)

После повторного запуска `ansible-playbook -i inventory/test.yml site.yml` задача `Print fact` выводит `"msg": "all default fact"`.

![Alt text](images/5.jpg)

3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.

Создаем образы Docker:

```
docker build -t centos7-python311 .
```

```
docker build -t ubuntu-python311 .
```

Dockerfile - ы в папках centos7, ubuntu22.04

Создаем файл docker-compose.yml:

```
services:
  centos:
    container_name: centos7
    image: centos7-python311:latest
    restart: on-failure
    command: ["sleep", "infinity"]
  ubuntu:
    container_name: ubuntu
    image: ubuntu-python311:latest
    restart: on-failure
    command: ["sleep", "infinity"]
```    

Запускаем:

```
docker comppose up -d
```

![Alt text](images/4.jpg)

![Alt text](images/5.jpg)

4. Проведите запуск playbook на окружении из `prod.yml`. Зафиксируйте полученные значения `some_fact` для каждого из `managed host`.

![Alt text](images/6.jpg)

5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились значения: для `deb` — `deb default fact`, для `el` — `el default fact`.
6.  Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.

![Alt text](images/7.jpg)

7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.

![Alt text](images/8.jpg)

8. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.

![Alt text](images/9.jpg)

9. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.

```
ansible-doc set_fact
```

![Alt text](images/10.jpg)

10. В `prod.yml` добавьте новую группу хостов с именем  `local`, в ней разместите localhost с необходимым типом подключения.

![Alt text](images/11.jpg)

11. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь, что факты `some_fact` для каждого из хостов определены из верных `group_vars`.

![Alt text](images/12.jpg)

12. Заполните `README.md` ответами на вопросы. Сделайте `git push` в ветку `master`. В ответе отправьте ссылку на ваш открытый репозиторий с изменённым `playbook` и заполненным `README.md`.
13. Предоставьте скриншоты результатов запуска команд.

## Необязательная часть

1. При помощи `ansible-vault` расшифруйте все зашифрованные файлы с переменными.
2. Зашифруйте отдельное значение `PaSSw0rd` для переменной `some_fact` паролем `netology`. Добавьте полученное значение в `group_vars/all/exmp.yml`.
3. Запустите `playbook`, убедитесь, что для нужных хостов применился новый `fact`.
4. Добавьте новую группу хостов `fedora`, самостоятельно придумайте для неё переменную. В качестве образа можно использовать [этот вариант](https://hub.docker.com/r/pycontribs/fedora).
5. Напишите скрипт на bash: автоматизируйте поднятие необходимых контейнеров, запуск ansible-playbook и остановку контейнеров.
6. Все изменения должны быть зафиксированы и отправлены в ваш личный репозиторий.

---

### Как оформить решение задания

Приложите ссылку на ваше решение в поле «Ссылка на решение» и нажмите «Отправить решение»
---
