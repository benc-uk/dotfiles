#!/bin/bash

NAME="cert"
DOMAIN="localhost"
#DOMAIN="myapp.benco.io"
IP="12.34.56.78"
DAYS="3650"

# Create a self-signed cert with a single command, with SNI/SAN
openssl req -x509 -newkey rsa:4096 -sha256 -days "$DAYS" -nodes \
  -keyout "$NAME".key -out "$NAME".pem -subj "/CN=$DOMAIN" \
  -addext "subjectAltName=DNS:$DOMAIN,IP:$IP"

# Convert to a PKCS12 file, you might want it in that format I dunno ¯\_(ツ)_/¯
#openssl pkcs12 -export -out "$NAME".p12 -inkey "$NAME".key -in "$NAME".pem
