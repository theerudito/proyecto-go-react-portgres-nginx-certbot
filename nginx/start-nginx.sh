#!/bin/bash

# Esperar hasta que los certificados estén generados por Certbot
until [ -f /etc/letsencrypt/live/docker.between-bytes.tech/fullchain.pem ]; do
  echo "Esperando que Certbot genere los certificados..."
  sleep 5
done

echo "Certificados SSL generados. Iniciando Nginx..."

# Iniciar Nginx
nginx -g "daemon off;"
