# Instalación y configuración de Laravel en Debian 12

Fuente: https://howtoforge.es/como-instalar-laravel-en-debian-12/

## Instalación de la pila LAMP

```
sudo apt update
sudo apt upgrade
sudo apt install apache2 php php-curl php-bcmath php-json php-mysql php-mbstring php-xml php-tokenizer php-zip mariadb-server
```

Verificar la instalación

```
systemctl status apache2
systemctl status mariadb
php -v
php -m
```

Abrimos el **navegador** y vemos la **IP del servidor**

## Configurar PHP

sudo vim /etc/php/8.2/apache2/php.ini

```
php -m | grep fileinfo
php -m | grep mbstring
php -m | grep openssl
```

Página de prueba

```
echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/info.php
```

## Configurar el servidor MariaDB

Instalación segura:
```
sudo mariadb-secure-installation
```

Ingresamos a la BD:
```
mariadb -u root -p
```

Ejecutamos lo siguiente:
```sql
CREATE DATABASE testapp;
CREATE USER testapp@localhost IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON testapp.* TO testapp@localhost;
FLUSH PRIVILEGES;
```

Verificamos los permisos del usuario **testapp**
```sql
SHOW GRANTS FOR testapp@localhost;
```

## Instalación de Composer

```
sudo apt install composer
which composer
sudo -u www-data composer --version
```

<!-- vi: set spl=es spell: -->
