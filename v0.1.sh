#!/bin/bash
# Script to deploy infrastructure for SecureDevOps

# Define variables
REGION="us-west-2"
ENVIRONMENT="dev"
APP_NAME="myapp"
INSTANCE_TYPE="t2.micro"
DB_INSTANCE_CLASS="db.t2.micro"
DB_ENGINE="mysql"
DB_NAME="mydb"
DB_USERNAME="admin"
DB_PASSWORD="mysecretpassword"

# Validate inputs
if [[ -z "$REGION" || -z "$ENVIRONMENT" || -z "$APP_NAME" || -z "$INSTANCE_TYPE" || -z "$DB_INSTANCE_CLASS" || -z "$DB_ENGINE" || -z "$DB_NAME" || -z "$DB_USERNAME" || -z "$DB_PASSWORD" ]]; then
  echo "One or more variables are not set."
  exit 1
fi

# Initialize Terraform
terraform init

# Validate Terraform configuration
terraform validate

# Generate Terraform plan
terraform plan \
  -var region="$REGION" \
  -var environment="$ENVIRONMENT" \
  -var app_name="$APP_NAME" \
  -var instance_type="$INSTANCE_TYPE" \
  -var db_instance_class="$DB_INSTANCE_CLASS" \
  -var db_engine="$DB_ENGINE" \
  -var db_name="$DB_NAME" \
  -var db_username="$DB_USERNAME" \
  -var db_password="$DB_PASSWORD" \
  -out terraform.plan

# Check for errors
if [[ $? -ne 0 ]]; then
  echo "An error occurred during Terraform plan generation."
  exit 1
fi

# Apply Terraform plan
terraform apply terraform.plan

# Check for errors
if [[ $? -ne 0 ]]; then
  echo "An error occurred during Terraform plan execution."
  exit 1
fi
