variable "aws_region" {
   default = "eu-west-1"
}

variable "availability_zones" {
   type    = list(string)
   default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "project_name" {
   default = "airflow"
}

variable "stage" {
   default = "dev"
}

variable "postgres_username" {
   default = "airflow"
}

variable "base_cidr_block" {
   default = "10.0.0.0"
}

variable "log_group_name" {
   default = "ecs/airflow"
}

variable "image_version" {
   default = "latest"
}

variable "metadata_db_instance_type" {
   default = "db.t2.micro"
}

variable "celery_backend_instance_type" {
   default = "cache.t2.small"
}

variable "volume_efs_name" {
   default = "efs-airflow"
}

variable "volume_efs_root_directory" {
   default = "/"
}

variable "airflow_local_folder_dags" {
   default = "/usr/local/airflow/dags"
}

variable "airflow_user" {
   default = "airflow"
}

variable "airflow_email" {
   default = "brunomachadoabreu@gmail.com"
}