#!/bin/bash

# Atualize a lista de pacotes
sudo apt-get update

# Instale pacotes necessários para usar o repositório HTTPS
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Adicione a chave GPG oficial do Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Adicione o repositório do Docker ao APT sources
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Atualize a lista de pacotes novamente
sudo apt-get update

# Instale o Docker
sudo apt-get install -y docker-ce

# Inicie e habilite o Docker
sudo systemctl start docker
sudo systemctl enable docker

# Instale o Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Navegue para o diretório onde o docker-compose.yml está localizado
cd /home/azureuser

# Crie o arquivo docker-compose.yml
cat <<EOF > docker-compose.yml
version: '3.1'

services:

  db:
    image: mysql:5.7
    volumes:
      - db_data:/var/lib/mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: GAud4mZby8F3SD6P
      MYSQL_DATABASE: createVM
      MYSQL_USER: useradmin
      MYSQL_PASSWORD: salvepauluk1

  wordpress:
    depends_on:
      - db
    image: wordpress:latest
    ports:
      - "80:80"
    restart: always
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: useradmin
      WORDPRESS_DB_PASSWORD: salvepauluk1
      WORDPRESS_DB_NAME: createVM

volumes:
  db_data:
EOF

# Inicie os containers usando Docker Compose
sudo docker-compose up -d
