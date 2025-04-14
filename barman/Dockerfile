# Используем базовый образ Debian или Ubuntu
FROM debian:latest

# Обновляем пакеты и устанавливаем необходимые зависимости
RUN apt-get update \ 
    && apt-get install -y \
    barman \
    # После установки рекомендуется очистка кеша, чтобы не раздувать размер контейнера
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Создание .ssh
RUN mkdir -p /var/lib/barman/.ssh && \
    chown barman:barman /var/lib/barman/.ssh && \
    chmod 700 /var/lib/barman/.ssh

#Копируем ключи для беспарольной атуентификации
COPY keys/id_rsa /var/lib/barman/.ssh/id_rsa
COPY keys/id_rsa.pub /var/lib/barman/.ssh/id_rsa.pub
RUN chmod 600 /var/lib/barman/.ssh/id_rsa
RUN chown barman:barman /var/lib/barman/.ssh/id_rsa
RUN chown barman:barman /var/lib/barman/.ssh/id_rsa.pub

# Копируем конфигурационные файлы
#Настройки barman
COPY barman/barman.conf /etc/barman.conf 
#Настройки бэкапа для конкретного сервера
COPY barman/pg.conf /etc/barman.d/pg.conf

#Файл с паролями для обеспечения взаимодествия с postgres без ввода пароля
COPY barman/.pgpass /var/lib/barman/.pgpass
# Настройка прав
RUN chown barman:barman /var/lib/barman/.pgpass
RUN chmod 600 /var/lib/barman/.pgpass

COPY barman/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Указываем entrypoint
ENTRYPOINT ["/entrypoint.sh"]
USER barman
CMD ["tail", "-f", "/dev/null"]