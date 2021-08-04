#resource "aws_spot_instance_request" "rdb" {
#  ami           = "${lookup(var.AmiLinux, var.region)}"
#  spot_price = "0.0116"
#  instance_type = "t2.small"
#  associate_public_ip_address = "false"
#  #availability_zone = "us-east-2b"
#  wait_for_fulfillment = "true"
#  subnet_id = "${aws_subnet.PrivateAZA.id}"
#  private_ip = "172.28.3.5"
#  vpc_security_group_ids = ["${aws_security_group.Database.id}"]
#  key_name = "${var.key_name}"
#  tags { 
#  		Name = "rdb" 
#  		Role = "Database"
#  }
#
#  user_data = "${file("rdb.txt")}"
#}
#
#
resource "aws_spot_instance_request" "rancher" {
  ami = "${lookup(var.AmiLinux, var.region)}"
  spot_price = "0.024"
  instance_type = "r4.large"
  associate_public_ip_address = "true"
  wait_for_fulfillment = "true"
  subnet_id = "${aws_subnet.PublicAZA.id}"
  vpc_security_group_ids = ["${aws_security_group.HTTP-HTTPS.id}", "${aws_security_group.SSH.id}"]
  key_name = "${var.key_name}"
  //depends_on = "aws_spot_instance_request.rdb"
  tags {
        Name = "rancher"
  }
#  provisioner "file" {
#    source      = "ssh/"
#    destination = "/root/ssh/"
#  }
  user_data = "${file("rancher.sh")}"
}

resource "aws_volume_attachment" "ebs_att_rancher" {
  device_name = "/dev/xvdh"
  volume_id = "vol-0321c975d0a808376"
  instance_id = "${aws_spot_instance_request.rancher.spot_instance_id}"
  skip_destroy = "true"
  force_detach = "true"

}