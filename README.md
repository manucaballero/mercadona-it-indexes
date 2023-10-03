# mercadona-it-indexes
Repo con información y ejemplos de los diferentes tipos de índices existentes


## Como empezar

Primero levanta la base de datos ejecutando el fichero *docker-compose.yaml* de la carpeta comienzo.

Para ello entra en la carpeta comienzo y ejecuta el siguiente comando:

`docker-compose up -d`

Una vez el contenedor esté levantado ejecuta en la base de datos mercadona-it-index el fichero **create-table.sql** , 
el cual creará la tabla productsales en la base de datos.

Tras esto importa los datos del fichero **insertdata.csv** en la tabla recién creada. Esto último insertará 2 millones de lineas en la misma.

Listo! Ya puedes empezar a trabajar con índices.
