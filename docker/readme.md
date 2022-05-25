# Datos a la base de datos

Necesario

* Docker
* Docker compose
* Los datos tienen que estar en la carpeta "challenge_data" con la siguiente estructura de carpetas:
  * ActivityLogs 
  * Attributes
  * Journals

Instrucciones, con docker andando

* docker compose up

Para testear, la recomendacion es usar dbeaver. Conexión

* Host: "localhost"
* Port: "5432"
* Database: "viz"
* Authentication: "Database Native"
* Username: "viz_user"
* Password: "viz_pass"