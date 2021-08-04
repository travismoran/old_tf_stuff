resource "aws_vpc_dhcp_options" "rdev01-dhcp" {
    domain_name = "${var.DnsZoneName}"
    domain_name_servers = ["AmazonProvidedDNS"]
    tags {
      Name = "My internal name"
    }
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
    vpc_id = "${aws_vpc.rdev01.id}"
    dhcp_options_id = "${aws_vpc_dhcp_options.rdev01-dhcp.id}"
}

/* DNS PART ZONE AND RECORDS */
resource "aws_route53_zone" "main" {
  name = "${var.DnsZoneName}"
  vpc_id = "${aws_vpc.rdev01.id}"
  comment = "Managed by terraform"
}

#resource "aws_route53_record" "" {
#   zone_id = "${aws_route53_zone.main.zone_id}"
#   name = "mydatabase.${var.DnsZoneName}"
#   type = "A"
#   ttl = "300"
#   records = ["${aws_spot_instance_request.rdb.private_ip}"]
#}

resource "aws_route53_record" "rancher" {
   zone_id = "YOUR53ZONEID"
   name = "rancher.rdev01.DOMAIN.com"
   type = "A"
   ttl = "300"
   records = ["${aws_spot_instance_request.rancher.public_ip}"]
}
