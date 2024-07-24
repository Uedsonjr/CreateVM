# Use a imagem oficial do WordPress
FROM wordpress:latest

# Copie qualquer arquivo adicional necessário
# COPY ./my-custom-file /usr/src/wordpress/

# Exponha a porta 80
EXPOSE 80
