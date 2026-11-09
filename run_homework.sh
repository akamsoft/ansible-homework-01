#!/bin/bash
set -e

cd "$(dirname "$0")"

cleanup() {
    echo "=== Остановка и удаление контейнеров ==="
    docker compose down
}
trap cleanup EXIT

echo "=== Запуск контейнеров ==="
docker compose up -d

echo "=== Ожидание готовности контейнеров ==="
sleep 3

echo "=== Запуск Ansible playbook ==="
cd playbook
# Приглашение Vault password: — введите netology и нажмите Enter.
# Символы при вводе не отображаются, это нормально.
ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass

echo "=== Готово ==="