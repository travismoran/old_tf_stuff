resource "aws_vpc_dhcp_options" "DOMAIN-dev-dhcp" {
    domain_name = "${var.DnsZoneName}"
    domain_name_servers = ["AmazonProvidedDNS"]
    tags {
      Name = "My internal name"
    }
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
    vpc_id = "${aws_vpc.DOMAIN-dev.id}"
    dhcp_options_id = "${aws_vpc_dhcp_options.DOMAIN-dev-dhcp.id}"
}

/* DNS PART ZONE AND RECORDS */
resource "aws_route53_zone" "main" {
  name = "${var.DnsZoneName}"
  vpc_id = "${aws_vpc.DOMAIN-dev.id}"
  comment = "Managed by terraform"
}

#resource "aws_route53_record" "rdb" {
#   zone_id = "${aws_route53_zone.main.zone_id}"
#   name = "mydatabase.${var.DnsZoneName}"
#   type = "A"
#   ttl = "300"
#   records = ["${aws_spot_instance_request.rdb.private_ip}"]
#}
#
#resource "aws_route53_record" "rancher-server-dev01" {
#   zone_id = "${aws_route53_zone.main.zone_id}"
#   name = "rancher-server-dev01.${var.DnsZoneName}"
#   type = "A"
#   ttl = "300"
#   records = ["${aws_spot_instance_request.rancher-server-dev01.private_ip}"]
#}
