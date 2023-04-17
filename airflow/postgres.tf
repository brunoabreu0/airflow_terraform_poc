resource "aws_security_group" "postgres_public" {
  name        = "${var.project_name}-${var.stage}-postgres-public-sg"
  description = "Allow all inbound for Postgres"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["${var.base_cidr_block}/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.stage}-postgres-public-sg"
  }
}

resource "aws_db_subnet_group" "airflow_subnet_group" {
  name       = "${var.project_name}-${var.stage}"
  subnet_ids = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id, aws_subnet.public-subnet-3.id]

  tags = {
    Name = "${var.project_name}-${var.stage}-subnet-group"
  }
}

data "aws_secretsmanager_secret_version" "airflow_postgres_pwd" {
  secret_id = aws_secretsmanager_secret.postgres_password.id
  depends_on = [aws_secretsmanager_secret_version.postgres_password_version]
}

resource "aws_db_instance" "metadata_db" {
  identifier = "${var.project_name}-${var.stage}-postgres"

  # database name
  db_name                = var.project_name
  instance_class         = var.metadata_db_instance_type
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "10.17"
  skip_final_snapshot    = true
  publicly_accessible    = true
  db_subnet_group_name   = aws_db_subnet_group.airflow_subnet_group.id
  vpc_security_group_ids = [aws_security_group.postgres_public.id]
  username               = var.postgres_username
  password               = data.aws_secretsmanager_secret_version.airflow_postgres_pwd.secret_string

  tags = {
    Name = "${var.project_name}-${var.stage}-postgres"
  }
}