последовательно необходимо выполнить следующие команды:
docker-compose up -d --build --build

#Проверяем наполнение базы данных
su postgres
psql
\c school
\dt
select * FROM students;

Проверяем соедиенние с postgres
barman check pg

Делаем резервную копию
barman backup pg

Изменяем структуру/наполнение бд

Останавливаем postgres
/usr/lib/postgresql/14/bin/pg_ctl -D /etc/postgresql/14/main stop

Получаем список бэкапов для нашего сервера, забираем айди нужного нам бэкапа
barman list-backups pg

barman --debug recover --remote-ssh-command "ssh postgres@pg" pg <айди бэкапа> /var/lib/postgresql/14/main

Запускаем postgres
/usr/lib/postgresql/14/bin/pg_ctl -D /etc/postgresql/14/main start
