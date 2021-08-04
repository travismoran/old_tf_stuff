#resource "aws_security_group" "nginx" {
#  name = "nginx"
#  tags {
#        Name = "nginx"
#  }
#  description = "ONLY HTTP CONNECTION INBOUD"
#  vpc_id = "${aws_vpc.terraformmain.id}"
#
#  ingress {
#        from_port = 80
#        to_port = 80
#        protocol = "TCP"
#        cidr_blocks = ["0.0.0.0/0"]
#  }
#  ingress {
#        from_port = 443
#        to_port = 443
#        protocol = "TCP"
#        cidr_blocks = ["0.0.0.0/0"]
#  }  
#  ingress {
#    from_port   = "22"
#    to_port     = "22"
#    protocol    = "TCP"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#  ingress {
#        from_port = 0
#        to_port = 0
#        protocol = "-1"
#        cidr_blocks = ["172.28.0.0/16"]
#  }
#  egress {
#    from_port = 0
#    to_port = 0
#    protocol = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#}
#
#resource "aws_security_group" "saltmaster" {
#  name = "saltmaster"
#  tags {
#        Name = "saltmaster"
#  }
#  description = "ONLY HTTP CONNECTION INBOUD"
#  vpc_id = "${aws_vpc.terraformmain.id}"
#
#  ingress {
#        from_port = 80
#        to_port = 80
#        protocol = "TCP"
#        cidr_blocks = ["18.218.127.177/32", "172.28.0.0/24"]
#  }
#  ingress {
#        from_port = 443
#        to_port = 443
#        protocol = "TCP"
#        cidr_blocks = ["18.218.127.177/32", "172.28.0.0/24"]
#  }  
#  ingress {
#    from_port   = "22"
#    to_port     = "22"
#    protocol    = "TCP"
#    cidr_blocks = ["18.218.127.177/32", "172.28.0.0/24"]
#  }
#  ingress {
#        from_port = 0
#        to_port = 0
#        protocol = "-1"
#        cidr_blocks = ["172.28.0.0/16"]
#  }
#  egress {
#    from_port = 0
#    to_port = 0
#    protocol = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#}
#
resource "aws_security_group" "app" {
  name = "app"
  tags {
        Name = "app"
  }
  description = "ONLY HTTP CONNECTION INBOUD"
  vpc_id = "${aws_vpc.terraformmain.id}"

#  ingress {
#        from_port = 80
#        to_port = 80
#        protocol = "TCP"
#        security_groups = ["${aws_security_group.nginx.id}"]
#  }
#    ingress {
#        from_port = 8080
#        to_port = 8080
#        protocol = "TCP"
#        security_groups = ["${aws_security_group.nginx.id}"]
#  }
#    ingress {
#        from_port = 8081
#        to_port = 8081
#        protocol = "TCP"
#        security_groups = ["${aws_security_group.nginx.id}"]
#  }
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["172.28.0.0/16"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#resource "aws_security_group" "iis" {
#  name = "iis"
#  tags {
#        Name = "iis"
#  }
#  description = "ONLY HTTP CONNECTION INBOUD"
#  vpc_id = "${aws_vpc.terraformmain.id}"
#
#  ingress {
#        from_port = 80
#        to_port = 80
#        protocol = "TCP"
#        security_groups = ["${aws_security_group.nginx.id}"]
#  }
#    ingress {
#        from_port = 8080
#        to_port = 8080
#        protocol = "TCP"
#        security_groups = ["${aws_security_group.nginx.id}"]
#  }
#    ingress {
#        from_port = 8081
#        to_port = 8081
#        protocol = "TCP"
#        security_groups = ["${aws_security_group.nginx.id}"]
#  }
#  ingress {
#    from_port   = "3389"
#    to_port     = "3389"
#    protocol    = "TCP"
#    security_groups = ["${aws_security_group.nginx.id}"]
#  }
#  ingress {
#        from_port = 0
#        to_port = 0
#        protocol = "-1"
#        cidr_blocks = ["172.28.0.0/16"]
#  }
#  egress {
#    from_port = 0
#    to_port = 0
#    protocol = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#}

resource "aws_security_group" "Database" {
  name = "Database"
  tags {
        Name = "Database"
  }
  description = "ONLY tcp CONNECTION INBOUND"
  vpc_id = "${aws_vpc.terraformmain.id}"
  ingress {
      from_port = 3306
      to_port = 3306
      protocol = "TCP"
      cidr_blocks = ["172.28.0.0/16"]
  }
  ingress {
      from_port   = "22"
      to_port     = "22"
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["172.28.0.0/16"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}