#!/usr/bin/env bash
set -euo pipefail
RG=${1:-mov-rg}
LOC=${2:-westeurope}
APP=${3:-mov-webapp}
IMG=${4:-YOUR_DOCKERHUB_USERNAME/mov2:1.0.0}

az account show >/dev/null 2>&1 || az login
az group create -n "$RG" -l "$LOC"
az appservice plan create -g "$RG" -n "${APP}-plan" --is-linux --sku P1v2
az webapp create -g "$RG" -p "${APP}-plan" -n "$APP" -i "$IMG"
az webapp config container set -g "$RG" -n "$APP"   --container-image-name "$IMG"   --container-registry-url "https://index.docker.io/v1/"
az webapp config appsettings set -g "$RG" -n "$APP" --settings PORT=8080 APP_NAME="MOV Inlämningsuppgift 2"
az webapp config set -g "$RG" -n "$APP" --health-check-path "/healthz"
az webapp show -g "$RG" -n "$APP" --query defaultHostName -o tsv
