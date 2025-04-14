#!/bin/bash
set -e

echo "Создание ролей..."
psql -U postgres <<EOF
DO \$\$
BEGIN
   IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'barman') THEN
      CREATE ROLE barman WITH SUPERUSER LOGIN PASSWORD 'barman';
   END IF;

   IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'streaming_barman') THEN
      CREATE ROLE streaming_barman WITH REPLICATION LOGIN PASSWORD 'barman';
   END IF;
END
\$\$;
EOF

echo "Создание базы и наполнение..."
psql -U postgres -tc "SELECT 1 FROM pg_database WHERE datname = 'school'" | grep -q 1 || psql -U postgres -c "CREATE DATABASE school;"
psql -U postgres -d school -f /populate.sql