# Instalación y configuración de Laravel en Debian 12

Fuente: https://howtoforge.es/como-instalar-laravel-en-debian-12/

## Instalación de la pila LAMP

```
sudo apt update
sudo apt upgrade
sudo apt install apache2 php php-curl php-bcmath php-json php-mysql php-mbstring php-xml php-tokenizer php-zip mariadb-server php-sqlite3
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

```
grep -r port /etc/mysql
sudo vim /etc/mysql/mariadb.cnf
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

## Crear el primer proyecto Laravel

Ir al lugar donde vas a poner el proyecto y compartir el directorio
con el contenedor

```
incus-share-this-dir.bash laravel-d12 testapp /var/www/testapp

```
y dentro del contenedor

```
sudo mkdir -p /var/www/{.cache,.config}
sudo chown -R www-data:www-data /var/www/{.cache,.config,testapp}

cd /var/www/testapp/
sudo -u www-data composer create-project laravel/laravel .
```
***Nota:*** Ver el documento `managing_permissions.md`

Editar el archivo `.env`

```
APP_URL=http://testapp.local

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=testapp
DB_USERNAME=testapp
DB_PASSWORD=password
```

Ahora ejecuta el siguiente comando para migrar la base de datos.
Esto creará tablas para el proyecto Laravel.

```
sudo -u www-data php artisan migrate
```

## Configuración del host virtual Apache

Activar el módulo de reescritura en Apache2

```
sudo a2enmod rewrite
sudo touch /etc/apache2/sites-available/laravel.conf
```

Editamos ese archivo con
```
<VirtualHost *:80>
  ServerAdmin webmaster@testapp.local
  ServerName testapp.local
  DocumentRoot /var/www/testapp/public

  <Directory /var/www/testapp/public>
    Options Indexes FollowSymLinks MultiViews
    AllowOverride All
    Require all granted
  </Directory>

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```

```
sudo a2ensite laravel.conf
sudo apachectl configtest
sudo systemctl restart apache2
```

## Acceder a Laravel

```
sudo vim /etc/hosts
```

```
192.168.10.15   testapp.local
```

<!-- vi: set spl=es spell: -->
