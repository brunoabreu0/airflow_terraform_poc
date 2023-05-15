resource "random_string" "random_postgres_password" {
  length  = 32
  upper   = true
  numeric = true
  special = false
}

resource "aws_secretsmanager_secret" "postgres_password" {
  name                    = "postgres_pwd"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "postgres_password_version" {
  secret_id     = aws_secretsmanager_secret.postgres_password.id
  secret_string = random_string.random_postgres_password.result
}

resource "random_string" "random_airflow_password" {
  length  = 32
  upper   = true
  numeric = true
  special = false
}

resource "aws_secretsmanager_secret" "airflow_password" {
  name                    = "airflow_pass"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "airflow_password_version" {
  secret_id     = aws_secretsmanager_secret.airflow_password.id
  secret_string = random_string.random_airflow_password.result
}