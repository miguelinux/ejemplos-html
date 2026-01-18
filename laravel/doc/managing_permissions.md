# Para uso y desarrollo en contenedores y otros

1. Add Your User to the `www-data` Group

```bash
sudo usermod -aG www-data your_username
```

2. Change Ownership of the Web Directory

```bash
sudo chown -R your_username:www-data /var/www/html/yourproject
```

3. Set Appropriate Permissions

```bash
# For general read access
sudo chmod -R 750 /var/www/html/yourproject

# For read/write access (e.g., for an uploads folder)
sudo chmod g+rw /var/www/html/yourproject/uploads
```
<hr>

En el framework Laravel, la escritura de datos está centralizada principalmente en dos directorios. Por razones de seguridad y arquitectura, estos son los únicos carpetas (junto con la de carga de archivos públicos) que deben tener **permisos de escritura** configurados en el servidor.

Aquí te detallo cuáles son y qué guardan exactamente:

---

### 1. El directorio `storage/`

Es el lugar principal donde Laravel escribe archivos durante la ejecución de la aplicación. Se divide en tres subdirectorios clave:

* **`storage/app`**: Se usa para guardar archivos generados por la aplicación (recibos, documentos, avatares). Dentro existe la carpeta `public` para archivos que deben ser accesibles desde la web mediante un enlace simbólico.
* **`storage/framework`**: Aquí el framework guarda archivos internos necesarios para su funcionamiento:
* `cache`: Datos temporales para acelerar la aplicación.
* `sessions`: Archivos de sesión de usuario (si usas el driver de `file`).
* `testing`: Archivos temporales generados durante pruebas unitarias.
* `views`: Versiones compiladas de tus plantillas Blade (archivos PHP puros).


* **`storage/logs`**: Contiene los archivos de registro (`laravel.log`) donde se reportan errores, excepciones y mensajes de depuración.

### 2. El directorio `bootstrap/cache/`

Aunque el código de tu aplicación vive en otras carpetas, Laravel escribe aquí para optimizar el rendimiento.

* Contiene archivos como `config.php`, `routes-v7.php` y `services.php`.
* Estos archivos son **cachés generadas** que combinan todas tus rutas y configuraciones en un solo archivo plano para que el framework no tenga que leer decenas de archivos en cada solicitud.

### 3. El directorio `public/` (Opcional)

Si tu aplicación permite que los usuarios suban imágenes o archivos que deben verse directamente en el navegador (como una foto de perfil), estos terminan escribiéndose técnicamente en `public/storage`.

> **Nota:** Generalmente, esto es un acceso directo (simlink) que apunta a `storage/app/public`.

---

### Resumen de Permisos

Si estás configurando un servidor Linux (Nginx/Apache), normalmente necesitas ejecutar comandos similares a estos para que Laravel pueda escribir:

```bash
sudo chown -R www-data:www-data storage bootstrap/cache
sudo chmod -R 775 storage bootstrap/cache

```

¿Estás teniendo algún error específico de "Permission denied" o necesitas ayuda para configurar el sistema de archivos (Filesystem) en la nube como AWS S3?

<!-- vi: set spl=es spell: -->

