# VARIABLES
variable "aws_access_key" {}
variable "aws_secret_key" {}


# PROVIDER
provider "aws" {
    access_key  =
    secret_key  =
    region      =
}


# INSTANCES
resource "aws_instance" "web_server01" {
    ami                     =
    instance_type           =
    subnet_id               =
    vpc_security_group_ids  =

    key_name =

    tags = {
        "Name" :
    }
}

resource "aws_instance" "web_server02" {
    ami                     =
    instance_type           =
    subnet_id               =
    vpc_security_group_ids  =

    key_name =

    tags = {
        "Name" :
    }
}


# SEC GROUP
resource "aws_security_group" "web_ssh" {
    name        = "ssh-access"
    description = "open ssh traffic"
    vpc_id      =
    
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        "Name" :
        "Terraform" : "true"
    }
}


# VPC
resource "aws_vpc" "test-vpc" {
    cidr_block           =
    enable_dns_hostnames = "true"
    
    tags = {
        "Name" :
    }
}


# ELASTIC IP
resource "aws_eip" "nat_eip_prob" {
    vpc = true
}


# NAT GATEWAY
resource "aws_nat_gateway" "nat_gateway_prob" {
    allocation_id = aws_eip.nat_eip_prob.id
    subnet_id     =
}


# SUBNETS
resource "aws_subnet" "subnet1" {
    cidr_block              =
    vpc_id                  =
    map_public_ip_on_launch = "true"
    availability_zone       = data.aws_availability_zones.available.names[0]
}

resource "aws_subnet" "pri_subnet1" {
    cidr_block              =
    vpc_id                  =
    map_public_ip_on_launch = "false"
    availability_zone       = data.aws_availability_zones.available.names[0]
}


# INTERNET GATEWAY
resource "aws_internet_gateway" "gw_1" {
    vpc_id =
}


# ROUTE TABLE
resource "aws_route_table" "route_table1" {
    vpc_id =

    route {
        cidr_block =
        gateway_id =
    }
}

resource "aws_route_table_association" "route-subnet1" {
    subnet_id      = aws_subnet.subnet1.id
    route_table_id = aws_route_table.route_table1.id
}


# PRIVATE ROUTE TABLE
resource "aws_route_table" "route_table2" {
    vpc_id =

    route {
        cidr_block     =
        nat_gateway_id =
    }
}

resource "aws_route_table_association" "route-subnet2" {
    subnet_id      =
    route_table_id =
}


# DATA
data "aws_availability_zones" "available" {
    state = "available"
}