resource "aws_ssm_parameter" "airflow_user_param" {
  name  = "airflow_user"
  type  = "String"
  value = var.airflow_user
}

resource "aws_ssm_parameter" "airflow_email_param" {
  name  = "airflow_email"
  type  = "String"
  value = var.airflow_email
}