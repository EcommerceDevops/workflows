#!/bin/bash

# Asignar roles específicos para GKE y recursos relacionados
PROJECT_ID="ecommerce-devops-utils"

# Crear una cuenta de servicio para Terraform
gcloud iam service-accounts create github-acc \
  --display-name="GitHub Actions Account for CI/CD" --project=$PROJECT_ID\

# Roles para administrar recursos de GKE
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:github-acc@$PROJECT_ID.iam.gserviceaccount.com" \
  --role="roles/container.admin"

# Roles para redes
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:github-acc@$PROJECT_ID.iam.gserviceaccount.com" \
  --role="roles/compute.networkAdmin"

# Roles para Artifact Registry
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:github-acc@$PROJECT_ID.iam.gserviceaccount.com" \
  --role="roles/artifactregistry.admin"

# Roles para Service Account User (necesario para crear recursos que usan cuentas de servicio)
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:github-acc@$PROJECT_ID.iam.gserviceaccount.com" \
  --role="roles/iam.serviceAccountUser"

gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:github-acc@$PROJECT_ID.iam.gserviceaccount.com" \
  --role="roles/iam.serviceAccountAdmin"

# Roles para administración de recursos generales en GCP
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:github-acc@$PROJECT_ID.iam.gserviceaccount.com" \
  --role="roles/resourcemanager.projectIamAdmin"

# Crear y descargar la clave de la cuenta de servicio
gcloud iam service-accounts keys create github.key.json \
  --iam-account=github-acc@$PROJECT_ID.iam.gserviceaccount.com