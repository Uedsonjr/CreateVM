# Deploy de WordPress na Azure com Terraform e Docker

Este repositório contém o código para criar uma VM na Azure, instalar Docker, e subir um container do WordPress, completamente automatizado usando Terraform.

## Pré-requisitos

- Azure CLI instalado e autenticado
- Terraform instalado
- Conta na Azure

## Estrutura do Projeto
      CreateVM/
      ├── main.tf
      ├── start_docker.sh
      └── README.md

## Passos para executar

1. Clone este repositório:
   ```bash
   git clone https://github.com/uedsonjr/createVM.git
   cd createVM
Aplicar a Configuração do Terraform

2. Navegue até o diretório do projeto:
         cd /caminho/para/createVM

      Inicialize o Terraform:

         terraform init
         
      Verifique o código

         terraform plan

      Aplique a configuração para criar a VM:

       terraform apply
