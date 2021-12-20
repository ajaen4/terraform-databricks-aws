# Databricks - AWS


## Introducción

Este proyecto se basa en el despliegue de una arquitectura en AWS para Databricks. La herramienta utilizada es Terraform.

[Link a la documentacion](https://docs.google.com/document/d/1ZaPrrdw3MCwOaSPQldkr9Z0C2WaQjK2Q1mHfA5BX6iY/edit#heading=h.juzm8wf61oip)

## Diagrama de Arquitectura

![Alt text](images/arquitectura_simple.png?raw=true "Title")

## Requisitos

- databrickslabs/databricks = 0.3.9
- hashicorp/aws = 3.49.0

## Despliegue infraestructura

Para el despliegue de la infraestructura es necesario rellenar el archivo de variables y el backend para el remote state.

## Scripts 

- reset_tokens: Cuando los tokens caduquen hay que ejecutar el script "reset_tokens.sh" para resetearlos. Este script hace un taint de los tokens utilizados y reaprovisiona el modulo databricks_provisioning individualmente, ya que los tokens se utilizan para autenticarse para databricks_management.
- sleep_network_infrastructure: Cuando no se vaya a utilizar el workspace se puede ejecutar el script "sleep_network_infrastructure" para eliminar las redes que pueden incurrir en costes (NAT, etc...)

## A tener en cuenta

A tener en cuenta:

- Debido a que las APIs de Databricks necesitan diferentes tipos de autenticacion se han tenido que crear diferentes proveedores de Databricks con diferentes  credenciales. 
- El service principal tiene limitaciones, no puede crear clusters ni ficheros en el dbfs, de ahi que se tenga que utilizar el proveedor con la autenticacion a traves de un pat token para la creación de estos recursos.
- En cuanto a la encriptacion, se encriptan todos las capas de persistencia (S3 y EBS) y se puede añadir la opcion de hacer la encriptacion en cliente. Para esto es necesario la inclusion del global init script para colocar el core-site.xml para hadoop y en el cluster añadir la configuracion necesaria para spark.

## Pendiente

- Añadir Private Links para realizar todo tipo de comunicacion a traves de canales privados
- Meter las credenciales en un Secret Manager en vez de tenerlas en el archivo de variables
- Incluir crawlers con Glue para el descubrimiento de metadatos
- Impacto del uso de Kinesis para el logging
- Añadir SSO