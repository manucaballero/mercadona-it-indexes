# mercadona-it-indexes
Repo con información y ejemplos de los diferentes tipos de índices existentes


## Como empezar

Primero levanta la base de datos ejecutando el fichero **docker-compose.yaml** de la carpeta comienzo.

Para ello entra en la carpeta comienzo y ejecuta el siguiente comando:

`docker-compose up -d`

Una vez el contenedor esté levantado ejecuta en la base de datos mercadona-it-index el fichero **create-table.sql** , 
el cual creará la tabla ventas en la base de datos y la rellenará de forma aleatoria con 10 millones de registros.

Listo! Ya puedes empezar a trabajar con índices.

Pd: En la carpeta info tienes documentación y ejemplos sobre los índices y sus tipos