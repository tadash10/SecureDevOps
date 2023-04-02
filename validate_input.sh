function validate_input() {
  # Validate inputs
  if [[ -z "$REGION" || -z "$ENVIRONMENT" || -z "$APP_NAME" || -z "$INSTANCE_TYPE" || -z "$DB_INSTANCE_CLASS" || -z "$DB_ENGINE" || -z "$DB_NAME" || -z "$DB_USERNAME" || -z "$DB_PASSWORD" ]]; then
    echo "One or more variables are not set."
    exit 1
  fi

  # Validate variable values
  if ! aws ec2 describe-regions --region $REGION >/dev/null 2>&1; then
    echo "Invalid region: $REGION"
    exit 1
  fi

  if ! aws ec2 describe-instance-types --instance-type $INSTANCE_TYPE >/dev/null 2>&1; then
    echo "Invalid instance type: $INSTANCE_TYPE"
    exit 1
  fi

  if [[ ! "$DB_ENGINE" =~ ^(mysql|postgres)$ ]]; then
    echo "Invalid database engine: $DB_ENGINE (supported engines: mysql, postgres)"
    exit 1
  fi
}
