#!/bin/bash
# Script to deploy infrastructure for SecureDevOps by Tadash10

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

# Define functions
function validate_input() {
  # Validate inputs
  if [[ -z "$REGION" || -z "$ENVIRONMENT" || -z "$APP_NAME" || -z "$INSTANCE_TYPE" || -z "$DB_INSTANCE_CLASS" || -z "$DB_ENGINE" || -z "$DB_NAME" || -z "$DB_USERNAME" || -z "$DB_PASSWORD" ]]; then
    echo "One or more variables are not set."
    exit 1
  fi
}

function init_terraform() {
  # Initialize Terraform
  terraform init
}

function validate_terraform() {
  # Validate Terraform configuration
  terraform validate
}

function generate_plan() {
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
}

function apply_plan() {
  # Apply Terraform plan
  terraform apply terraform.plan

  # Check for errors
  if [[ $? -ne 0 ]]; then
    echo "An error occurred during Terraform plan execution."
    exit 1
  fi
}

# Define menu options
while true
do
  clear
  echo "============================================"
  echo "SecureDevOps Infrastructure Deployment Script"
  echo "============================================"
  echo "1. Initialize Terraform"
  echo "2. Validate Terraform"
  echo "3. Generate Terraform Plan"
  echo "4. Apply Terraform Plan"
  echo "5. Quit"
  echo "============================================"
  read -p "Please enter your choice: " choice
  case $choice in
    1)
      init_terraform
      ;;
    2)
      validate_terraform
      ;;
    3)
      validate_input
      generate_plan
      ;;
    4)
      validate_input
      apply_plan
      ;;
    5)
      break
      ;;
    *)
      echo "Invalid option. Please choose again."
      ;;
  esac
  read -p "Press enter to continue"
done

# Disclaimer
echo "This script is provided as is and without warranty of any kind. Tadash10 is not responsible for any damages or liabilities that may arise from its use."
