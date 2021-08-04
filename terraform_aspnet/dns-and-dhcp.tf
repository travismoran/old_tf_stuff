resource "aws_vpc_dhcp_options" "mydhcp" {
    domain_name = "${var.DnsZoneName}"
    domain_name_servers = ["AmazonProvidedDNS"]
    tags {
      Name = "My internal name"
    }
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
    vpc_id = "${aws_vpc.terraformmain.id}"
    dhcp_options_id = "${aws_vpc_dhcp_options.mydhcp.id}"
}

/* DNS PART ZONE AND RECORDS */
resource "aws_route53_zone" "main" {
  name = "${var.DnsZoneName}"
  vpc_id = "${aws_vpc.terraformmain.id}"
  comment = "Managed by terraform"
}

resource "aws_route53_record" "iisdemo" {
   zone_id = "${aws_route53_zone.main.zone_id}"
   name = "iisdemo.${var.DnsZoneName}"
   type = "A"
   ttl = "300"
   records = ["${aws_spot_instance_request.iisdemo.private_ip}"]
}
