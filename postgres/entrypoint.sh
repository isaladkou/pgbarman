#!/bin/bash

set -e

PG_BIN="/usr/lib/postgresql/14/bin/postgres"

# Запуск SSH-сервера от root
echo "Starting SSH server..."
/usr/sbin/sshd


# Запуск PostgreSQL в фоне
echo "Starting PostgreSQL in background..."
su - postgres -c "$PG_BIN -D /etc/postgresql/14/main" &

# Ждем, пока сервер поднимется
echo "Waiting for PostgreSQL to start..."
sleep 5

# Запуск init-db.sh
echo "Running init-db.sh..."
chmod +x /init-db.sh
su - postgres -c "bash /init-db.sh"

tail -f /dev/null