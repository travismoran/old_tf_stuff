resource "aws_security_group" "HTTP-HTTPS" {
  name = "HTTP-HTTPS"
  tags {
        Name = "HTTP-HTTPS"
  }
  description = "ONLY HTTP CONNECTION INBOUD"
  vpc_id = "${aws_vpc.DOMAIN-dev.id}"

  ingress {
        from_port = 80
        to_port = 80
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "HTTP-ALT-8080" {
  name = "HTTP-ALT-8080"
  tags {
        Name = "HTTP-ALT-8080"
  }
  description = "ONLY HTTP-ALT-8080 CONNECTION INBOUD"
  vpc_id = "${aws_vpc.DOMAIN-dev.id}"

  ingress {
        from_port = 8080
        to_port = 8080
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "SSH" {
  name = "SSH"
  tags {
        Name = "SSH"
  }
  description = "ONLY SSH CONNECTION INBOUD"
  vpc_id = "${aws_vpc.DOMAIN-dev.id}"


  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "MySQL" {
  name = "MySQL"
  tags {
        Name = "MySQL"
  }
  description = "ONLY tcp CONNECTION INBOUND"
  vpc_id = "${aws_vpc.DOMAIN-dev.id}"
  ingress {
      from_port = 3306
      to_port = 3306
      protocol = "TCP"
      cidr_blocks = ["172.28.0.0/16"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}