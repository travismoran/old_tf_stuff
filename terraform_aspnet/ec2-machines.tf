resource "aws_spot_instance_request" "frontend" {
  ami = "${lookup(var.AmiLinux, var.region)}"
  spot_price = "0.0116"
  instance_type = "t2.small"
  associate_public_ip_address = "true"
  wait_for_fulfillment = "true"
  subnet_id = "${aws_subnet.PublicAZA.id}"
  vpc_security_group_ids = ["${aws_security_group.FrontEnd.id}"]
  key_name = "${var.key_name}"
  tags {
        Name = "frontend"
  }
  user_data = "${file("acme_sharp_letsencrypt_module.ps1")}"
}
