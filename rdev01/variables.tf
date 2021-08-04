variable "region" {
  default = "us-east-2"
}
variable "AmiLinux" {
  type = "map"
  default = {
    us-east-2 = "ami-0a3f7856b18ebea88"
    us-west-2 = "AMIHERE"
    eu-west-1 = "AMIHERE"
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
  default = "YOURDOMAINaws"
  description = "the ssh key to use in the EC2 machines"
}
variable "DnsZoneName" {
  default = "rdev01.DOMAIN.internal"
  description = "the dns zone name"
}

variable "priv_ips" {
    default = {
        "0" = "172.28.3.5"
        "1" = "172.28.3.6"
        "2" = "172.28.3.7"
    }
}
