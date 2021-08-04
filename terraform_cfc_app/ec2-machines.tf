resource "aws_spot_instance_request" "app01" {
  ami           = "${lookup(var.AmiLinux, var.region)}"
  spot_price = "0.0116"
  instance_type = "t2.micro"
  associate_public_ip_address = "false"
  #availability_zone = "us-east-2b"
  wait_for_fulfillment = "true"
  subnet_id = "${aws_subnet.PrivateAZA.id}"
  private_ip = "172.28.3.10"
  vpc_security_group_ids = ["${aws_security_group.app.id}"]
  key_name = "${var.key_name}"
  tags { 
  		Name = "app01" 
  		Role = "Application"
  }
  root_block_device {
    volume_type           = "standard"
    volume_size           = 8
    delete_on_termination = true
  }
#  provisioner "remote-exec" {
#    inline = [
#      "sudo apt-get update",
#      "sudo apt-get install --yes nfs-common",
#      "sudo mkdir /efs",
#      "sudo chown -R ubuntu /efs",
#      "sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 ${aws_efs_file_system.fs.dns_name}:/ /efs",
#    ]
#  }
#  resource "aws_efs_file_system" "fs" {
#  tags {
#    Name = "cfcefs"
#  }
   user_data = "${file("db01.sh")}"
}

#resource "aws_volume_attachment" "ebs_att_db" {
#  device_name = "/dev/xvdh"
#  volume_id = "vol-06f512b5de2732ca9"
#  instance_id = "${aws_spot_instance_request.db.spot_instance_id}"
#  skip_destroy = "true"
#  force_detach = "true"
#
#}

#resource "aws_spot_instance_request" "app" {
#  ami           = "${lookup(var.AmiLinux, var.region)}"
#  spot_price = "0.025"
#  instance_type = "t2.small"
#  associate_public_ip_address = "false"
#  #availability_zone = "us-east-2a"
#  wait_for_fulfillment = "true"
#  subnet_id = "${aws_subnet.PrivateAZA.id}"
#  private_ip = "172.28.3.6"
#  vpc_security_group_ids = ["${aws_security_group.AppServer.id}"]
#  key_name = "${var.key_name}"
#  tags { 
#  		Name = "app" 
#  		Role = "AppServer"
#  }
#root_block_device {
#    volume_type           = "standard"
#    volume_size           = 8
#    delete_on_termination = true
#  }
#  user_data = "${file("app.sh")}"
#}
#
##resource "aws_volume_attachment" "ebs_att" {
##  device_name = "/dev/xvdh"
##  volume_id = "vol-0809bc82fa83c0e1a"
##  instance_id = "${aws_spot_instance_request.app.spot_instance_id}"
##  skip_destroy = "true"
##  force_detach = "true"
##
##}
#
#resource "aws_spot_instance_request" "nginx" {
#  ami = "${lookup(var.AmiLinux, var.region)}"
#  spot_price = "0.0116"
#  instance_type = "t2.small"
#  associate_public_ip_address = "true"
#  private_ip = "172.28.0.20"
#  wait_for_fulfillment = "true"
#  subnet_id = "${aws_subnet.PublicAZA.id}"
#  vpc_security_group_ids = ["${aws_security_group.nginx.id}"]
#  key_name = "${var.key_name}"
#  tags {
#        Name = "nginx"
#  }
#  root_block_device {
#    volume_type           = "standard"
#    volume_size           = 8
#    delete_on_termination = true
#  }
#  user_data = "${file("nginx.sh")}"
#}
#
##resource "aws_volume_attachment" "ebs_att_nginx" {
##  device_name = "/dev/xvdh"
##  volume_id = "vol-078e7f9006d1bad34"
##  instance_id = "${aws_spot_instance_request.nginx.spot_instance_id}"
##  skip_destroy = "true"
##  force_detach = "true"
##
##}
#
#resource "aws_spot_instance_request" "saltmaster" {
#  ami = "${lookup(var.AmiLinux, var.region)}"
#  spot_price = "0.0116"
#  instance_type = "t2.small"
#  associate_public_ip_address = "true"
#  private_ip = "172.28.0.10"
#  wait_for_fulfillment = "true"
#  subnet_id = "${aws_subnet.PublicAZA.id}"
#  vpc_security_group_ids = ["${aws_security_group.saltmaster.id}"]
#  key_name = "${var.key_name}"
#  tags {
#        Name = "saltmaster"
#  }
#  root_block_device {
#    volume_type           = "standard"
#    volume_size           = 8
#    delete_on_termination = true
#  }
#  user_data = "${file("saltmaster.sh")}"
#}
#
##resource "aws_volume_attachment" "ebs_att_saltmaster" {
##  device_name = "/dev/xvdh"
##  volume_id = "vol-03c189f78c0392981"
##  instance_id = "${aws_spot_instance_request.saltmaster.spot_instance_id}"
##  skip_destroy = "true"
##  force_detach = "true"
##
##}
#
##resource "aws_spot_instance_request" "iis" {
##  ami           = "${lookup(var.AmiLinux, var.region)}"
##  spot_price = "0.0116"
##  instance_type = "t2.small"
##  associate_public_ip_address = "false"
##  #availability_zone = "us-east-2b"
##  wait_for_fulfillment = "true"
##  subnet_id = "${aws_subnet.PrivateAZA.id}"
##  private_ip = "172.28.3.40"
##  vpc_security_group_ids = ["${aws_security_group.iis.id}"]
##  key_name = "${var.key_name}"
##  tags { 
##  		Name = "iis" 
##  		Role = "iis"
##  }
##  root_block_device {
##    volume_type           = "standard"
##    volume_size           = 30
##    delete_on_termination = true
##  }
##
###  user_data = "${file("db.sh")}"
##}
##
##resource "aws_volume_attachment" "ebs_att_iis" {
##  device_name = "/dev/xvdh"
##  volume_id = "vol-0af6be2bcf30d2ed6"
##  instance_id = "${aws_spot_instance_request.iis.spot_instance_id}"
##  skip_destroy = "true"
##  force_detach = "true"
##
#}