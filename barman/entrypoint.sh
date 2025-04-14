#!/bin/bash
set -e


# Установка переменной окружения
export PGPASSFILE=/var/lib/barman/.pgpass

# Выполнение Barman
barman cron
barman switch-wal --force --archive pg
barman check pg

# Оставить контейнер активным (или запусти что-то полезное)
exec "$@"
