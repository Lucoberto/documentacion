### Ver informacion de un contenedor en runtime
> ¡ Con coger  los primeros 3 numeros del ID vale !
```
docker inspect 1a3
```

### Eliminar un contenedor del listado de contenedores parados
```
docker rm 1a3
```
### Ver logs de contenedores
```
docker logs 1a3

o listar primeras 300 lineas

docker logs --tail 300 1a3
```

### Mapear contenedores en puertos aleatorios
> ¡ Sirve por si quieres automatizar el despliegue de contenedores !
```
docker run -P nginx:latest
```

### Pasar variables en docker
> ¡ Se suele usar con DDBB para pasar el user, contraseñas, etc.
> Estas pueden ser accedidas por cualquier aplicacion dentro del contenedor. Ej: echo $MY_ROOT_PASSWORD!
```
docker -e MY_ROOT_PASSWORD=myPasswd mysql:latest
```

### Comunicacion contenedores via links
>¡ pako sera el nombre con el que resuelva la IP de la maquian 1a2, son unidireccionales!
```
docker run -d -it --link 1a2:pako ubuntu:latest bash
```

### Comunicacion via redes
>¡ Con network connect conectamos un contenedor via red utilizando un alias myownweb mediante el cual sera resuelto en la red.
```
docker network connect --alias myownweb myownnet 1a2
```

### Crear un docker file
> ¡Despues de crear el archivo de nombre Dockerfile escribimos el siguiente codigo en su interior!
```
# Imagen base
FROM ubuntu:latest

# Con run conseguimos que durante la instalacion docker lanze conados.
RUN mkdir -p /work/{python , stylepy}
# Le asignamos cual sera el directorio donde debe iniciar
WORKDIR /work/

# Copia de archivos de la maquina host al contenedor
COPY docker-doc.md /work/
COPY deploy.sh /work/

# Le decimos que se mueva al directorio donde esta la APP
RUN cd /work/proxmox-autodeploy

# Decimos que exponga el puerto 9080
EXPOSE 9080

# Es lo que arranca segun startea el contenedor
CMD ["bash","deploy.sh"]
```
> ¡ Ahora hay que buildear la imagen. Con -t indicamos un tag y con . le decimos la carpeta que debe coger!
```
docker build -t test:latest .
```

### Gestion de contenedores docker-compose
> ¡ Cada vez que ejecutemos el compose usara el mismo contenedor con las mismas caracteristicas!
```
version: '2'

# Crea una network
networks:
  testnetwork:

# Definir los servicios "contenedores"
services:
# Nombre del servicio
  ubuntuone:
# Imagen de la que vamos a partir
    image: "ubuntu:latest"
# Asignamos puertos
    ports:
      - 8080:80
# Lo conectamos a la red
    networks:
      - testnetwork

  ubuntutwo:
# Instenta montal el docker file
    build: ./
    ports:
      - 9580:80
    networks:
      testnetwork:
# El nombre por el que se encontrara dentro de la red
        aliases:
          - pako
```
> ¡ Para hacer el deploy de los contenedores debemos ejecutar el siguiente comando!
```
docker-compose up -d
```
