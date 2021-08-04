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

resource "aws_route53_record" "db" {
   zone_id = "${aws_route53_zone.main.zone_id}"
   name = "db.${var.DnsZoneName}"
   type = "A"
   ttl = "300"
   records = ["${aws_spot_instance_request.db.private_ip}"]
}

resource "aws_route53_record" "app" {
   zone_id = "${aws_route53_zone.main.zone_id}"
   name = "app.${var.DnsZoneName}"
   type = "A"
   ttl = "300"
   records = ["${aws_spot_instance_request.app.private_ip}"]
}

#resource "aws_route53_record" "iis" {
#   zone_id = "${aws_route53_zone.main.zone_id}"
#   name = "app.${var.DnsZoneName}"
#   type = "A"
#   ttl = "300"
#   records = ["${aws_spot_instance_request.iisdev.private_ip}"]
#}

resource "aws_route53_record" "rancher" {
   zone_id = "${aws_route53_zone.main.zone_id}"
   name = "rancher.${var.DnsZoneName}"
   type = "A"
   ttl = "300"
   records = ["${aws_spot_instance_request.saltmaster.private_ip}"]
}

resource "aws_route53_record" "nginx" {
   zone_id = "${aws_route53_zone.main.zone_id}"
   name = "nginx.${var.DnsZoneName}"
   type = "A"
   ttl = "300"
   records = ["${aws_spot_instance_request.nginx.private_ip}"]
}

resource "aws_route53_record" "saltmaster" {
   zone_id = "${aws_route53_zone.main.zone_id}"
   name = "saltmaster.${var.DnsZoneName}"
   type = "A"
   ttl = "300"
   records = ["${aws_spot_instance_request.saltmaster.private_ip}"]
}
