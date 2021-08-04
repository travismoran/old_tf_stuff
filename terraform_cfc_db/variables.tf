variable "region" {
  default = "us-east-2"
}
variable "AmiLinux" {
  type = "map"
  default = {
    us-east-2 = "ami-07ff31620efd69936"
	#us-east-2 = "ami-1fcdfc7a"
    us-west-2 = "ami-5ec1673e"
    eu-west-1 = "ami-9398d3e0"
  }
  description = "I add only 3 regions (Virginia, Oregon, Ireland) to show the map feature but you can add all the r"
}
## USER3 account
#variable "aws_access_key" {
#  default = "AWSKEYHERE"
#  description = "the user aws access key"
#}
#variable "aws_secret_key" {
#  default = "AWSSECRETHERE"
#  description = "the user aws secret key"
#}

# USER@YOURDOMAIN.com account 
variable "aws_access_key" {
  default = "AWSKEYHERE"
  description = "the user aws access key"
}
variable "aws_secret_key" {
  default = "AWSSECRETHERE"
  description = "the user aws secret key"
}

variable "vpc-fullcidr" {
  default = "172.28.0.0/16"
  description = "the vpc cdir"
}
variable "Subnet-Public-AzA-CIDR" {
  default = "172.28.0.0/24"
  description = "the cidr of the subnet"
}
variable "Subnet-Private-AzA-CIDR" {
  default = "172.28.3.0/24"
  description = "the cidr of the subnet"
}
variable "key_name" {
  default = "awscfc"
  description = "the ssh key to use in the EC2 machines"
}
variable "DnsZoneName" {
  default = "YOURDOMAIN.internal"
  description = "the internal dns name"
}
#variable "DnsZoneNamePublic" {
#  default = "YOURDOMAIN.com"
#  description = "the external dns name"
#}
variable "pub_ips" {
    default = {
        "0" = "172.28.0.20"
        "1" = "172.28.0.21"
        "2" = "172.28.0.22"
		"3" = "172.28.0.23"
    }
}
variable "priv_ips" {
    default = {
        "0" = "172.28.3.5"
        "1" = "172.28.3.6"
        "2" = "172.28.3.7"
		"3" = "172.28.3.8"
    }
}