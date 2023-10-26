### Instalar minikube
> ¡En mi caso uso opensuse por eso descargo la version rpm!
```
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-latest.x86_64.rpm

sudo rpm -Uvh minikube-latest.x86_64.rpm
```
### Inciar minikube
```
minikube start
```
### Solucion error: ❌  Saliendo por un error DRV_NOT_HEALTHY:
> ¡En caso de que te salga este error prueba usando el siguiente commado!
```
sudo usermod -aG docker $USER && newgrp docker
```
### Instalar cliente kubernetes (kubectl)
```
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
```
### Dar permisos
```
chmod 777 kubectl
```
### "Instalacion manual" mover al bin
```
mv ./kubectl /usr/local/bin
```
### Iniciar dashboard de minikube
```
minikube dashboard
```
### Listar los nodos
```
kubectl get nodes
```
### Deploy de pods
> ¡hello-nginx sera el nombre y con --image decimos cual sera la imagen que queremos deployar!
```
kubectl create deployment hello-nginx --image=nginx:latest
```
### Listar pods
```
kubectl get pods
```
### Informacion sobre el pod
```
kubectl decribe pod hello-nginx
```
### Configuracion fichero para deploy de pod
```
# Version del fichero
apiVersion: v1

# Tipo de deploy
kind: Pod

# Informacion sobre la applicacion
metadata:
  name: miownapp
  labels:
    app: web

# Especificaciones de la aplicacion
spec:
# Contenedores que vamos a desplegar
  containers:
# Nombre de contenedor
    - name: ngi
# Imagen que vamos a utilizar
      image: nginx
# Puertos que abrimos 
      ports:
        - containerPort: 80
    
    - name: ngidos
      image: nginx
```
### Deploy del pod yml
> ¡ -f se usa para indicar el fichero!
```
kubectl apply -f app.yml
```
### Exponer el servicio
> ¡En este caso exponemos un puerto y activamos la funcion de balanceo de carga!
```
kubectl expose deployment hello-nginx --type=LoadBalancer --port=8080
```
### Listar servicios activos
```
kubectl get services
```
### Hacer un pod auto escalable
> ¡Con el parametro replicas consegiremos que se creen 5 copias del mismo pod!
```
kubectl scale deployment --replicas=5 hello-nginx
```
### Borrar los pods
```
kubectl delete deployment hello-nginx
```
### Borrar aplicacion desplegada con yml
> ¡ -f indica el fichero! 
```
kubectl delete -f app.yml
```
### Borrar servicios
```
kubectl delete services
```
### Cerrar el cluster
```
minikube delete
```
### Crear app con modo interactivo
```
---
# Version del fichero
apiVersion: v1

# Tipo de deploy
kind: Pod

# Informacion sobre la applicacion
metadata:
  name: lit
  labels:
    app: web

# Especificaciones de la aplicacion
spec:
# Contenedores que vamos a desplegar
  containers:
# Nombre de contenedor
    - name: ngi
# Imagen que vamos a utilizar
      image: nginx
# Puertos que abrimos 
      ports:
        - containerPort: 80
    
    - name: ubuntuk
      image: ubuntu:latest
      command: ["/bin/sh"]
# Se hace un bucle para evitar que muera el contenedor
      args: ["-c", "while true; do echo hello; sleep 10; done"]
```
### Entrar en modo interactivo "Terminal"
> ¡ con -c decimos cual sera el contenedor y delante de -it ira el pod ! 
```
kubectl exec -it lit -c ubuntuk /bin/bash
```
### Exponer servicios
> ¡ NodePort abre un puerto en el nodo master al exterior, ClusterIp nos da IP que solo esta disponible dentro del cluster !
```
kubectl expose lit --port=80 --type=ClusterIP
```
