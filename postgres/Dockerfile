FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Установка необходимых пакетов
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    openssh-server \
    rsync \
    sudo \
    lsb-release \
    postgresql \
    postgresql-contrib\
    nano

RUN sed -i "s/#wal_level = replica/wal_level = replica/" /etc/postgresql/14/main/postgresql.conf
RUN sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /etc/postgresql/14/main/postgresql.conf
RUN sed -i "/# IPv4 local connections:/a host    all             barman          0.0.0.0/0               md5" /etc/postgresql/14/main/pg_hba.conf
RUN sed -i "/# replication privilege./a host    replication streaming_barman   0.0.0.0/0                md5" /etc/postgresql/14/main/pg_hba.conf


# Создание каталогов
RUN mkdir -p /var/run/sshd /var/lib/postgresql/.ssh

# Настройка SSH-доступа
COPY keys/id_rsa.pub /var/lib/postgresql/.ssh/authorized_keys
RUN chmod 700 /var/lib/postgresql/.ssh && \
    chmod 600 /var/lib/postgresql/.ssh/authorized_keys && \
    chown -R postgres:postgres /var/lib/postgresql/.ssh

COPY keys/id_rsa.pub /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys

# Копируем SQL и скрипты
COPY postgres/init-db.sh /init-db.sh
COPY postgres/populate.sql /populate.sql
COPY postgres/entrypoint.sh /entrypoint.sh
RUN chmod +x /init-db.sh /entrypoint.sh

# Открываем порты
EXPOSE 5432

# Запускаем кастомный entrypoint
CMD ["/entrypoint.sh"]
