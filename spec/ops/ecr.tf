variable "aws_region" {
}

provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_ecr_repository" "publish_example_stub" {
  name = "publish_example_stub"
}
