#!/bin/bash
set -e

# Переход в директорию скрипта
cd "$(dirname "$0")"

echo "=== Запуск контейнеров ==="
docker compose up -d
# Даем контейнерам немного времени на запуск
sleep 3

echo "=== Запуск Ansible playbook ==="
cd playbook
# Пароль для vault можно передать через файл или запросить интерактивно
ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass

echo "=== Остановка и удаление контейнеров ==="
cd ..
docker compose down

echo "=== Готово ==="