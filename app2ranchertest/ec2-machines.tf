// ubuntu 18.04LTS base AMI: ami-0c55b159cbfafe1f0
// ubuntu 14.04 LTS modified image(docker v1.10 + rancher agent linked to ami-06189f753bb9771f0): ami-022d1f10b4cdaf63d
// ubuntu 14.04 LTS modified image(docker v1.10 + rancher v1.0.0): ami-06189f753bb9771f0
// vipmigtest01 - ubuntu 14.04 LTS modified image(docker v1.10 + rancher v1.0.0): ami-011e17c742557513a

resource "aws_spot_instance_request" "rdb" {
  ami           = "ami-011e17c742557513a"
  spot_price = "0.0116"
  instance_type = "t2.small"
  associate_public_ip_address = "true"
  //availability_zone = "us-east-2b"
  wait_for_fulfillment = "true"
  subnet_id = "${aws_subnet.PublicAZA.id}"
  private_ip = "172.28.0.5"
  vpc_security_group_ids = ["${aws_security_group.FrontEnd.id}"]
  key_name = "${var.key_name}"
  tags { 
  		Name = "rdb" 
  		Role = "Database"
  }

  user_data = "${file("rdb.txt")}"
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = "${aws_spot_instance_request.rdb.spot_instance_id}"
  allocation_id = "eipalloc-09d07ac47f0bee239"
}

resource "aws_spot_instance_request" "frontend" {
  ami = "ami-0c55b159cbfafe1f0"
  spot_price = "0.0116"
  instance_type = "t2.small"
  associate_public_ip_address = "true"
  wait_for_fulfillment = "true"
  subnet_id = "${aws_subnet.PublicAZA.id}"
  private_ip = "172.28.0.6"
  vpc_security_group_ids = ["${aws_security_group.FrontEnd.id}"]
  key_name = "${var.key_name}"
  //depends_on = "aws_spot_instance_request.rdb"
  tags {
        Name = "frontend"
  }
  user_data = "${file("DOMAIN-APP2.txt")}"
}

resource "aws_eip_association" "eip_assoc1" {
  instance_id   = "${aws_spot_instance_request.frontend.spot_instance_id}"
  allocation_id = "eipalloc-007bd765a36e4af73"
}
//
//resource "aws_spot_instance_request" "frontend2" {
//  ami = "ami-022d1f10b4cdaf63d"
//  spot_price = "0.0116"
//  instance_type = "t2.small"
//  associate_public_ip_address = "true"
//  wait_for_fulfillment = "true"
//  subnet_id = "${aws_subnet.PublicAZA.id}"
//  private_ip = "172.28.0.8"
//  vpc_security_group_ids = ["${aws_security_group.FrontEnd.id}"]
//  key_name = "${var.key_name}"
//  //depends_on = "aws_spot_instance_request.rdb"
//  tags {
//        Name = "frontend2"
//  }
//  user_data = "${file("frontend2.txt")}"
//}
//
//resource "aws_eip_association" "eip_assoc2" {
//  instance_id   = "${aws_spot_instance_request.frontend2.spot_instance_id}"
//  allocation_id = "eipalloc-0a34ceccf2b3c18fc"
//}