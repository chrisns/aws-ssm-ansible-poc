provider "aws" {
  region = "eu-west-2"
}

resource "aws_security_group" "allow_http" {
  name = "allow_http"
  description = "Allow all inbound http traffic"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "linux" {
  instance_type = "t2.micro"
  ami = "ami-0664a710233d7c148" # <-- amazon linux 2 image
  security_groups = [   "allow_http"]
  iam_instance_profile = "${aws_iam_instance_profile.ssmdemo.name}"
  tags = {
    Name = "ssmdemo"
  }
}

module "session-manager-settings" {
  source  = "gazoakley/session-manager-settings/aws"

  s3_bucket_name            = "ssmdemo"
  cloudwatch_log_group_name = "ssmdemo"
  cloudwatch_encryption_enabled = false
  s3_encryption_enabled = false
}
resource "aws_cloudwatch_log_group" "ssmdemo" {
  name = "ssmdemo"
}

data "aws_iam_policy" "ssmdemo" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

resource "aws_iam_role_policy_attachment" "ssmdemo" {
  role = "${aws_iam_role.ssmdemo.name}"
  policy_arn = "${data.aws_iam_policy.ssmdemo.arn}"
}

resource "aws_iam_instance_profile" "ssmdemo" {
  role = "${aws_iam_role.ssmdemo.name}"
}

resource "aws_iam_role" "ssmdemo" {
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}
