
# HomeLab -> Jenkins

Este repositorio git despliega un Jenkins sobre Docker como docker-compose.

 1. [Prerequisitos](#prerequisitos)
 2. [Despliegue](#despliegue)
 3. [Parada](#parada)
 4. [Ejemplo](#ejemplo)

## Prerequisitos

Ambas aplicaciones utilizan volúmenes externos para guardar sus configuraciones y datos. En el fichero ***docker-compose.yml*** se encuentran definidos estos volúmenes. Estos volúmenes crear el directorio automáticamente, sin embargo, en el caso de Jenkins es necesario que se creen previamente y se les asigne el propietario al usuario *"1000"*. Esto es debido a que Jenkins utiliza ese usuario para escribir.

    $ sudo mkdir /srv/jenkins
    $ sudo mkdir /srv/jenkins/jenkins_home
    $ sudo chown 1000 /srv/jenkins
    $ sudo chown 1000 /srv/jenkins/jenkins_home

## Despliegue

Una vez descargado en proyecto, accede a la ruta donde se encuentro el fichero ***docker-compose.yml*** y ejecuta el siguiente comando:

    $ docker-compose up -d

## Parada

Para parar y borrar los contenedores creados, basta con ejecutar el siguiente comando:

    $ docker-compose down

