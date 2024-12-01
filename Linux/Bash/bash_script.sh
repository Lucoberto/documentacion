#!/bin/bash

# Imprimir por pantalla
echo "Hello Wolrd"

# Variables
dihola="Hellow world"
echo $dihola

# Salida de un comando en una variable
salida_ls=$(ls -lha)
echo $salida_ls

# Array
array=(1 2 3)
echo ${array[@]} # Mostrar todos los arrays
echo ${array[1]} # Mostrar array por posicion

# Solicitar introduccion de datos
echo "Quien eres -> "
read nombre
echo "Hola $nombre"

# Condiciones if, else, elif
if [ "Hola" == "Hola" ]; then
	echo "esta condicion se dara si son iguales"

elif [ 1 -lt 2 ]; then
	echo "esta condicion se dara en caso de que sea mayor que"

elif [ 1 -gt 2 ]; then
	echo "esta condicion se dara en caso de que sea menor que"

elif [ $dihola -eq $salida_ls ]; then
	echo "esta condicion se da su las variables son iguales"

else
	echo "si ninguna condicion se da se ejecuta lo siguiente"
fi

# Condiciones avanzadas
if [ -f "file.txt" ]; then # -f archivo, -d directorio, -e archivo o directorio
	echo "buscara la existencia del archivo"
else
	echo "no encuentra el archivo"
fi

# Doble condicon
if [ -d "dir" ] && [ -f "archivo.txt"  ]; then
	echo "archivo existe y directorio existen"
else
	echo "no se encuentran"
fi

# Bucle for
for count_array in ${array[@]}; do # Itera sobre un array
	echo $count_array
done

for contador in {1..5}; do
	echo "tiempo: $contador"
done

# Bucle while
contadorDos=0
while [ $contadorDos -le 5 ]; do # Bucle con condicion
	echo "Tiempo de contador dos $contadorDos"
	((contadorDos ++))
done

# Funcion
funcion(){
	# Codigo que se va a ejecutar
	echo "Hola que tal soy una funcion, solo funciono si me llamas funcion"
}

funcion # Llamada a la funcion

# Argumentos
if [ $1 == $2 ]; then
	echo "$1 igual $2"
elif [ $# -lt 2 ]; then # Comprobacion de cuantos argumentos hemos puesto
	echo "argumentos insuficientes"
else
	echo "No es igual"
fi

# Casos (switch)
read -p "Selecciona una opcion: (1,2,3): " opcionesDos
case $opcionesDos in
	1)
		echo "opcion 1"
	;;

	2)
		echo "opcion 2"
	;;

	3)
		echo "opcion 3"
	;;
esac

# Getopts
while getopts ":a:b:" opciones; do
	case $opciones in
		a)
			echo "Opcion -a $OPTARG"
		;;

		b)
			echo "Opcion -b $OPTARG"
		;;

		*)
			echo "Opcion no valida"
		;;
	esac
done
