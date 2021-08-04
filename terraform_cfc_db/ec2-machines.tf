resource "aws_spot_instance_request" "db01" {
  ami           = "ami-041b06c32b5e8cd82"
  spot_price = "0.0116"
  instance_type = "t2.small"
  associate_public_ip_address = "false"
  #availability_zone = "us-east-2b"
  wait_for_fulfillment = "true"
  subnet_id = "${aws_subnet.PrivateAZA.id}"
  private_ip = "172.28.3.5"
  vpc_security_group_ids = ["${aws_security_group.Database.id}","${aws_security_group.default.id}"]
  #security_groups = ["${aws_security_group.Database.id},${aws_security_group.default.id}"]
  key_name = "${var.key_name}"
  user_data = "${file("db01.sh")}"
  tags { 
  		Name = "db01" 
  		Role = "Database"
  }
  root_block_device {
    volume_type           = "standard"
    volume_size           = 8
    delete_on_termination = true
  }
}
resource "aws_spot_instance_request" "db02" {
  ami           = "ami-0da54956b0275dd81"
  spot_price = "0.0116"
  instance_type = "t2.small"
  associate_public_ip_address = "false"
  #availability_zone = "us-east-2b"
  wait_for_fulfillment = "true"
  subnet_id = "${aws_subnet.PrivateAZA.id}"
  private_ip = "172.28.3.6"
  vpc_security_group_ids = ["${aws_security_group.Database.id}","${aws_security_group.default.id}"]
  #security_groups = ["${aws_security_group.Database.id}","${aws_security_group.default.id}"]
  key_name = "${var.key_name}"
  user_data = "${file("db02.sh")}"
  tags { 
  		Name = "db02" 
  		Role = "Database"
  }
  root_block_device {
    volume_type           = "standard"
    volume_size           = 8
    delete_on_termination = true
  }
}
resource "aws_spot_instance_request" "db03" {
  ami           = "ami-032bad6ce277193ef"
  spot_price = "0.0116"
  instance_type = "t2.small"
  associate_public_ip_address = "false"
  #availability_zone = "us-east-2b"
  wait_for_fulfillment = "true"
  subnet_id = "${aws_subnet.PrivateAZA.id}"
  private_ip = "172.28.3.7"
  vpc_security_group_ids = ["${aws_security_group.Database.id}","${aws_security_group.default.id}"]
  #security_groups = ["${aws_security_group.Database.id}","${aws_security_group.default.id}"]
  key_name = "${var.key_name}"
  user_data = "${file("db03.sh")}"
  tags { 
  		Name = "db03" 
  		Role = "Database"
  }
  root_block_device {
    volume_type           = "standard"
    volume_size           = 8
    delete_on_termination = true
  }
}  
resource "aws_spot_instance_request" "app01" {
  ami           = "ami-0aba892ca74486a2e"
  spot_price = "0.0155"
  instance_type = "t2.medium"
  associate_public_ip_address = "false"
  #availability_zone = "us-east-2b"
  wait_for_fulfillment = "true"
  subnet_id = "${aws_subnet.PrivateAZA.id}"
  private_ip = "172.28.3.10"
  vpc_security_group_ids = ["${aws_security_group.app.id}","${aws_security_group.default.id}"]
  #security_groups = ["${aws_security_group.app.id},${aws_security_group.default.id}"]
  key_name = "${var.key_name}"
  user_data = "${file("app01.sh")}"
  tags { 
  		Name = "app01" 
  		Role = "Application"
  }
  root_block_device {
    volume_type           = "standard"
    volume_size           = 8
    delete_on_termination = true
  }
}

resource "aws_spot_instance_request" "app02" {
  ami           = "ami-081c8d234a8fe0597"
  spot_price = "0.0155"
  instance_type = "t2.medium"
  associate_public_ip_address = "false"
  #availability_zone = "us-east-2b"
  wait_for_fulfillment = "true"
  subnet_id = "${aws_subnet.PrivateAZA.id}"
  private_ip = "172.28.3.11"
  vpc_security_group_ids = ["${aws_security_group.app.id}","${aws_security_group.default.id}"]
  #security_groups = ["${aws_security_group.app.id},${aws_security_group.default.id}"]
  key_name = "${var.key_name}"
  user_data = "${file("app02.sh")}"
  tags { 
  		Name = "app02" 
  		Role = "Application"
  }
  root_block_device {
    volume_type           = "standard"
    volume_size           = 8
    delete_on_termination = true
  }
}

resource "aws_spot_instance_request" "app03" {
  ami           = "ami-0bf5b53517a3d2fd1"
  spot_price = "0.0155"
  instance_type = "t2.medium"
  associate_public_ip_address = "false"
  #availability_zone = "us-east-2b"
  wait_for_fulfillment = "true"
  subnet_id = "${aws_subnet.PrivateAZA.id}"
  private_ip = "172.28.3.12"
  vpc_security_group_ids = ["${aws_security_group.app.id}","${aws_security_group.default.id}"]
  #security_groups = ["${aws_security_group.app.id},${aws_security_group.default.id}"]
  key_name = "${var.key_name}"
  user_data = "${file("app03.sh")}"
  tags { 
  		Name = "app03" 
  		Role = "Application"
  }
  root_block_device {
    volume_type           = "standard"
    volume_size           = 8
    delete_on_termination = true
  }
}

resource "aws_spot_instance_request" "nginx01" {
  ami           = "ami-01a208a18f4834750"
  spot_price = "0.0116"
  instance_type = "t2.micro"
  associate_public_ip_address = "true"
  #availability_zone = "us-east-2b"
  wait_for_fulfillment = "true"
  subnet_id = "${aws_subnet.PublicAZA.id}"
  private_ip = "172.28.0.20"
  vpc_security_group_ids = ["${aws_security_group.nginx.id}","${aws_security_group.default.id}"]
  #security_groups = ["${aws_security_group.nginx.id},${aws_security_group.default.id}"]
  key_name = "${var.key_name}"
  user_data = "${file("nginx01.sh")}"
  tags { 
  		Name = "nginx01" 
  		Role = "Web"
  }
  root_block_device {
    volume_type           = "standard"
    volume_size           = 8
    delete_on_termination = true
  }
}

resource "aws_spot_instance_request" "nginx02" {
  ami           = "ami-01a208a18f4834750"
  spot_price = "0.0116"
  instance_type = "t2.micro"
  associate_public_ip_address = "true"
  #availability_zone = "us-east-2b"
  wait_for_fulfillment = "true"
  subnet_id = "${aws_subnet.PublicAZA.id}"
  private_ip = "172.28.0.21"
  vpc_security_group_ids = ["${aws_security_group.nginx.id}","${aws_security_group.default.id}"]
  #security_groups = ["${aws_security_group.nginx.id},${aws_security_group.default.id}"]
  key_name = "${var.key_name}"
  user_data = "${file("nginx02.sh")}"
  tags { 
  		Name = "nginx02" 
  		Role = "Web"
  }
  root_block_device {
    volume_type           = "standard"
    volume_size           = 8
    delete_on_termination = true
  }
}

resource "aws_spot_instance_request" "nginx03" {
  ami           = "ami-01a208a18f4834750"
  spot_price = "0.0116"
  instance_type = "t2.micro"
  associate_public_ip_address = "true"
  #availability_zone = "us-east-2b"
  wait_for_fulfillment = "true"
  subnet_id = "${aws_subnet.PublicAZA.id}"
  private_ip = "172.28.0.22"
  vpc_security_group_ids = ["${aws_security_group.nginx.id}","${aws_security_group.default.id}"]
  #security_groups = ["${aws_security_group.nginx.id},${aws_security_group.default.id}"]
  key_name = "${var.key_name}"
  user_data = "${file("nginx03.sh")}"
  tags { 
  		Name = "nginx03" 
  		Role = "Web"
  }
  root_block_device {
    volume_type           = "standard"
    volume_size           = 8
    delete_on_termination = true
  }
}