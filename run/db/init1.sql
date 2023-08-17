-- Create databases
CREATE DATABASE IF NOT EXISTS realmd DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS characters DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS mangos DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS logs DEFAULT CHARSET utf8 COLLATE utf8_general_ci;

-- Create user and grant privilege
create user '$DB_USER'@'localhost' identified by '$DB_USER';
SET PASSWORD FOR '$DB_USER'@'localhost' = PASSWORD('$DB_PASSWORD');
GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_USER';
flush privileges;
grant all on realmd.* to '$DB_USER'@'localhost' with grant option;
grant all on characters.* to '$DB_USER'@'localhost' with grant option;
grant all on mangos.* to '$DB_USER'@'localhost' with grant option;
grant all on logs.* to '$DB_USER'@'localhost' with grant option;
flush privileges;
