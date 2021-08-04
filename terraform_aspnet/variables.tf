variable "region" {
  default = "us-east-2"
}
variable "AmiLinux" {
  type = "map"
  default = {
    us-east-2 = "ami-bc784ed9"
    us-west-2 = "ami-5ec1673e"
    eu-west-1 = "ami-9398d3e0"
  }
  description = "I add only 3 regions (Virginia, Oregon, Ireland) to show the map feature but you can add all the r"
}
variable "aws_access_key" {
  default = "AWSKEYHERE"
  description = "the user aws access key"
}
variable "aws_secret_key" {
  default = "AWSSECRETHERE"
  description = "the user aws secret key"
}
variable "vpc-fullcidr" {
    default = "172.29.0.0/16"
  description = "the vpc cdir"
}
variable "Subnet-Public-AzA-CIDR" {
  default = "172.29.0.0/24"
  description = "the cidr of the subnet"
}
variable "Subnet-Private-AzA-CIDR" {
  default = "172.29.3.0/24"
  description = "the cidr of the subnet"
}
variable "key_name" {
  default = "YOURDOMAINaws"
  description = "the ssh key to use in the EC2 machines"
}
variable "DnsZoneName" {
  default = "YOURDOMAIN.internal"
  description = "the internal dns name"
}

variable "priv_ips" {
    default = {
        "0" = "172.29.3.5"
        "1" = "172.29.3.6"
        "2" = "172.29.3.7"
		"3" = "172.29.3.8"
		"4" = "172.29.3.9"
		"5" = "172.29.3.10"
		"6" = "172.29.3.11"
		"7" = "172.29.3.12"
		"8" = "172.29.3.13"
		"9" = "172.29.3.14"
		"10" = "172.29.3.15"
    }
}