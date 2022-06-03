# Datos a la base de datos

Necesario

* Docker
* Docker compose
* Los datos tienen que estar en la carpeta "challenge_data" con la siguiente estructura de carpetas:
  * Activity Logs 
  * Attributes
  * Journals
* Ejecutar el notebook: "docker/Notebooks/05.preproc_activity.ipynb"
  * Esto va a preprocesar todos los archivos de "Activity logs", y los va a guardar en "fix_activity_logs"

(Si no es la primera vez que ejecutan)

* Eliminar la carpeta "postgres-data" si es que la tuvieran 
* Eliminen la maquina de docker (y el volumen)

Instrucciones, con docker andando

* docker compose up -d

Para testear, la recomendacion es usar dbeaver. Conexión

* Host: "localhost"
* Port: "5432"
* Database: "viz"
* Authentication: "Database Native"
* Username: "viz_user"
* Password: "viz_pass"