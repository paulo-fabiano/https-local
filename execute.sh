#!/bin/bash
echo "##### Iniciando Nginx na Porta 443 #####"

# Executando o Container
docker run -d --name nginx --network host -v ~/Documentos/nginx/conf.d:/etc/nginx/conf.d -v ~/Documentos/nginx/ssl-certificados:/etc/nginx/ssl nginx
