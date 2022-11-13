# USUARIOS Y GRUPOS

## Crear usuarios:

```c
adduser "NombreUsuario"
```

## Crear usuario nuevo y añadirlo al grupo:

**Despues de utilizar el parametro _-g_ hay que poner el primer grupo al que pertenecera el usuario.**

```c
useradd -g "GrupoPrimario" -G "GrupoUno","GrupoDos" "NombreUsuario"
```

## Listar usuarios y grupos:

```linux
less /etc/group
```

## Añadir usuario existente a gurpo:

**Para añadir un usuario al grupo siempre hay que usar la propiedad _-a_, si no lo haces el usuario se ra eliminado de todos los grupos que no esten especificados detras de el parametro _-G_.**

```c
usermod -aG "Grupo" "NombreUsuario"
```

## Añadir usuario a multiples grupos:

```c
usermod -aG "GrupoUno","GrupoDos" "NombreUsuario"
```

## Eliminar usuario de grupo:

```c
gpasswd -d "NombreUsuario" "Grupo"
```

## Cambiar grupo primario del usuario:

```c
usermod -g "GrupoNuevo" "NombreUsuario"
```

## Mostrar los grupos a los que pertenece el usuario:

```c
id "NombreUsusario"
--
groups "NombreUsuario"
```
___

## Crear Grupo:

```c
groupadd "Grupo"
```

## Eliminar grupo:

```c
groupdel "Grupo"
```

# PERMISOS

## Permisos basicos usuarios:

* **Owner**  > Usuario 
* **Group**  > Grupo al que pertenece
* **Others** > Todos los demas usuarios

## Listar permisos de archivos:

```c
ls -l
```

## Como leer permisos:

* **Primera parte:** Permisos del archivo.
* **Segunda parte:** El creador del archivo.
* **Tercera parte:** Grupo al que pertenece el creador.
* **Cuarta parte:** Fecha de creacion del archivo.

```c
drwxr-xr-x 2 root root 4096 nov 13 14:12 guerillaOne
```

## Permisos basicos de archivo:

**Con el permiso "execute" podemos ejecutar cualquier tipo de archivo ya sea poder entrar en una carpeta o ejecutar un binario.**

* **r** > Read
* **w** > Wirte
* **x** > Execution

## Como leer permisos de archivo:

* **Primer parte:** tipo de archivo ( "-" Archivo, "d" Directorio, "i" Link ).
* **Segunda parte:** Permisos del creador (owner).
* **Tercera parte:** Permisos del grupo del creador (Group).
* **Cuarta parte:** Permisos del resto de usuarios (Others).

```c
drwxr-xr-x
```

## Dar permisos al archivo con symbolos:

**Para dar permisos a un archivo mediante simbolos, tenemos que tener en cuenta el significador de las variables:** _"u" User, "g" Group, "o" Others_.

```c
chmod u=rwx,g=wx,o=r "NombreArchivo"
```

## Dar permiso al archivo con numeros octales:

**Para dar permisos a un archivo mediante numeros octales, tenemos que tener en cuenta el significador de cada numero:** _el primer numero se refiere al User, el segundo al Group y el tercero a Others_.

```c
chmod 775 "NombreArchivo"
```

## Permisos basicos octal:

* **read** > 4
* **write** > 2
* **execute** > 1
* **no permission** > 0


Numeros | Permisos
---------|----------
 7 | R W X 
 6 | R W 
 5 | R X
 4 | R
 2 | W
 1 | X
 0 | N/A

# PROPIETARIOS

## Cambiar usuaro propietario del archivo:

```c
chown "NombreUsuario" "NombreArchivo"
```

## Cambiar grupo propietario del archivo:

**Si cambiamos el grupo del archivo mediante chown tenemos que poner: ":" ya que con esto se especifica que es un grupo.**

```c
chgrp "Grupo" "NombreArchivo"
--
chown :"Grupo" "NombreArchivo"

```

## Cambiar usuaro y grupo propietario del archivo:

```c
chown "NombreUsuario":"Grupo" "NombreArchivo"
```

