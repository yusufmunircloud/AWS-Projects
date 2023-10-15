#------------------------------------------#
# AWS Provider Configuration
#------------------------------------------#
provider "aws" {
    region = "${var.region}"
}
#------------------------------------------#
# AWS VPC Configuration
#------------------------------------------#
resource "aws_vpc" "rancher_ha" {
    cidr_block           = "${var.vpc_cidr}"
    enable_dns_support   = true
    enable_dns_hostnames = true
    tags {
        Name = "${var.name_prefix}-vpc"
    }
}

resource "aws_subnet" "rancher_ha" {
    count                   = "3"
    vpc_id                  = "${aws_vpc.rancher_ha.id}"
    cidr_block              = "${element(var.subnet_cidrs, count.index)}"
    availability_zone       = "${element(var.availability_zones, count.index)}"
    map_public_ip_on_launch = true
    tags {
      Name = "${var.name_prefix}-subnet-${count.index}"
    }
}

resource "aws_internet_gateway" "rancher_ha" {
    vpc_id     = "${aws_vpc.rancher_ha.id}"
    depends_on = ["aws_vpc.rancher_ha"]
    tags {
      Name = "${var.name_prefix}-igw"
    }
}

resource "aws_route" "rancher_ha" {
    route_table_id         = "${aws_vpc.rancher_ha.main_route_table_id}"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = "${aws_internet_gateway.rancher_ha.id}"
    depends_on             = ["aws_vpc.rancher_ha", "aws_internet_gateway.rancher_ha"]
}

resource "aws_vpc_dhcp_options" "rancher_dns" {
    domain_name         = "ec2.internal"
    domain_name_servers = ["169.254.169.253", "AmazonProvidedDNS"]
}

resource "aws_vpc_dhcp_options_association" "rancher_dns" {
    vpc_id          = "${aws_vpc.rancher_ha.id}"
    dhcp_options_id = "${aws_vpc_dhcp_options.rancher_dns.id}"
}
#------------------------------------------#
# AWS EC2 Configuration
#------------------------------------------#
resource "aws_instance" "rancher_ha" {
    count                       = "${var.count}"
    ami                         = "${var.ami}"
    instance_type               = "${var.instance_type}"
    key_name                    = "${var.key_name}"
    user_data                   = "${data.template_file.install.rendered}"
    subnet_id                   = "${element(sort(aws_subnet.rancher_ha.*.id), count.index)}"

    vpc_security_group_ids = ["${aws_security_group.rancher_ha.id}"]

    tags {
        Name = "${var.name_prefix}-${count.index}"
    }

    root_block_device {
        volume_size = "${var.root_volume_size}"
        delete_on_termination = true
    }
    depends_on = ["aws_rds_cluster_instance.rancher_ha"]
}

data "template_file" "install" {
    template = <<-EOF
                #cloud-config
                write_files:
                - content: |
                    #!/bin/bash
                    wait-for-docker
                    docker run -d --restart=unless-stopped \
                      -p 8080:8080 -p 9345:9345 \
                      rancher/server:$${rancher_version} \
                      --db-host $${db_host} \
                      --db-name $${db_name} \
                      --db-port $${db_port} \
                      --db-user $${db_user} \
                      --db-pass $${db_pass} \
                      --advertise-address $(ip route get 8.8.8.8 | awk '{print $NF;exit}')
                  path: /etc/rc.local
                  permissions: "0755"
                  owner: root
                EOF

    vars {
        rancher_version = "${var.rancher_version}"
        db_host         = "${aws_rds_cluster.rancher_ha.endpoint}"
        db_name         = "${aws_rds_cluster.rancher_ha.database_name}"
        db_port         = "${aws_rds_cluster.rancher_ha.port}"
        db_user         = "${var.db_user}"
        db_pass         = "${var.db_pass}"
    }
}

resource "aws_security_group" "rancher_ha" {
    name        = "${var.name_prefix}-server"
    description = "Rancher HA Server Ports"
    vpc_id      = "${aws_vpc.rancher_ha.id}"

    ingress {
        from_port = 0
        to_port   = 65535
        protocol  = "tcp"
        self      = true
    }

    ingress {
        from_port = 0
        to_port   = 65535
        protocol  = "udp"
        self      = true
    }

    ingress {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["${var.vpc_cidr}"]
    }

    ingress {
        from_port   = 9345
        to_port     = 9345
        protocol    = "tcp"
        cidr_blocks = ["${var.vpc_cidr}"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

#------------------------------------------#
# Elastic Load Balancer Common Configuration
#------------------------------------------#
resource "aws_security_group" "rancher_ha_elb" {
    name        = "${var.name_prefix}-elb-default"
    description = "Rancher HA ELB Common Traffic"
    vpc_id      = "${aws_vpc.rancher_ha.id}"
}

resource "aws_security_group_rule" "allow_all_self" {
    type              = "ingress"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    self              = true
    security_group_id = "${aws_security_group.rancher_ha_elb.id}"
}

resource "aws_security_group_rule" "allow_icmp" {
    type              = "ingress"
    from_port         = 0
    to_port           = 0
    protocol          = "icmp"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.rancher_ha_elb.id}"
}

resource "aws_security_group_rule" "allow_all_out" {
    type              = "egress"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.rancher_ha_elb.id}"
}

#------------------------------------------#
# Elastic Load Balancer Configuration
#------------------------------------------#
resource "aws_elb" "rancher_ha_http" {
    count    = "${1 - var.enable_https}"
    name     = "${var.name_prefix}-elb-http"
    internal = "${var.internal_elb}"

    listener {
        instance_port     = 8080
        instance_protocol = "tcp"
        lb_port           = 80
        lb_protocol       = "tcp"
    }

    health_check {
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 3
        target              = "HTTP:8080/ping"
        interval            = 30
    }

    subnets         = ["${aws_subnet.rancher_ha.*.id}"]
    security_groups = ["${aws_security_group.rancher_ha_elb.id}"]
    instances       = ["${aws_instance.rancher_ha.*.id}"]

    idle_timeout                = 400
    cross_zone_load_balancing   = true
    connection_draining         = true
    connection_draining_timeout = 400

    tags {
        Name = "${var.name_prefix}-elb-http"
    }
}

resource "aws_proxy_protocol_policy" "rancher_ha_http_proxy_policy" {
    count          = "${1 - var.enable_https}"
    load_balancer  = "${aws_elb.rancher_ha_http.name}"
    instance_ports = ["80", "81", "8080"]
}

resource "aws_security_group_rule" "allow_http" {
    count             = "${1 - var.enable_https}"
    type              = "ingress"
    from_port         = 80
    to_port           = 80
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.rancher_ha_elb.id}"
}

#------------------------------------------#
# Elastic Load Balancer Configuration
#------------------------------------------#
resource "aws_elb" "rancher_ha_https" {
    count    = "${var.enable_https}"
    name     = "${var.name_prefix}-elb-https"
    internal = "${var.internal_elb}"

    listener {
        instance_port      = 8080
        instance_protocol  = "tcp"
        lb_port            = 443
        lb_protocol        = "ssl"
        ssl_certificate_id = "${aws_iam_server_certificate.rancher_ha.arn}"
    }

    health_check {
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 3
        target              = "HTTP:8080/ping"
        interval            = 30
    }

    subnets         = ["${aws_subnet.rancher_ha.*.id}"]
    security_groups = ["${aws_security_group.rancher_ha_elb.id}"]
    instances       = ["${aws_instance.rancher_ha.*.id}"]

    idle_timeout                = 400
    cross_zone_load_balancing   = true
    connection_draining         = true
    connection_draining_timeout = 400

    tags {
        Name = "${var.name_prefix}-elb-https"
    }
}

resource "aws_iam_server_certificate" "rancher_ha" {
    count             = "${var.enable_https}"
    name              = "${var.name_prefix}-certificate"
    certificate_body  = "${file("${var.cert_body}")}"
    private_key       = "${file("${var.cert_private_key}")}"
    certificate_chain = "${file("${var.cert_chain}")}"
}

resource "aws_proxy_protocol_policy" "rancher_ha_https_proxy_policy" {
    count          = "${var.enable_https}"
    load_balancer  = "${aws_elb.rancher_ha_https.name}"
    instance_ports = ["81", "443", "8080"]
}

resource "aws_security_group_rule" "allow_https" {
    count             = "${var.enable_https}"
    type              = "ingress"
    from_port         = 443
    to_port           = 443
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.rancher_ha_elb.id}"
}

#------------------------------------------#
# RDS Database Configuration
#------------------------------------------#
resource "aws_rds_cluster_instance" "rancher_ha" {
    count                = 2
    identifier           = "${var.name_prefix}-db-${count.index}"
    cluster_identifier   = "${aws_rds_cluster.rancher_ha.id}"
    instance_class       = "db.t2.medium"
    publicly_accessible  = false
    db_subnet_group_name = "${aws_db_subnet_group.rancher_ha.name}"
}

resource "aws_rds_cluster" "rancher_ha" {
    cluster_identifier     = "${var.name_prefix}-db"
    database_name          = "${var.db_name}"
    master_username        = "${var.db_user}"
    master_password        = "${var.db_pass}"
    db_subnet_group_name   = "${aws_db_subnet_group.rancher_ha.name}"
    vpc_security_group_ids = ["${aws_security_group.rancher_ha_rds.id}"]
    storage_encrypted      =  true

}

resource "aws_db_subnet_group" "rancher_ha" {
    name        = "${var.name_prefix}-db-subnet-group"
    description = "Rancher HA Subnet Group"
    subnet_ids  = ["${aws_subnet.rancher_ha.*.id}"]
    tags {
        Name = "${var.name_prefix}-db-subnet-group"
    }
}

resource "aws_security_group" "rancher_ha_rds" {
    name        = "${var.name_prefix}-rds-secgroup"
    description = "Rancher RDS Ports"
    vpc_id      = "${aws_vpc.rancher_ha.id}"

    ingress {
        from_port = 0
        to_port   = 65535
        protocol  = "tcp"
        self      = true
    }

    ingress {
        from_port = 0
        to_port   = 65535
        protocol  = "udp"
        self      = true
    }

    ingress {
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        cidr_blocks = ["${var.vpc_cidr}"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

#------------------------------------------#
# AWS Outputs
#------------------------------------------#
output "elb_http_dns" {
    value = "${aws_elb.rancher_ha_http.dns_name}"
}

output "elb_https_dns" {
    value = "${aws_elb.rancher_ha_https.dns_name}"
}

#------------------------------------------#
# AWS Environment Variables
#------------------------------------------#
variable "region" {
    default     = "us-west-2"
    description = "The region of AWS, for AMI lookups"
}

variable "count" {
    default     = "2"
    description = "Number of HA servers to deploy"
}

variable "name_prefix" {
    default     = "rancher-ha"
    description = "Prefix for all AWS resource names"
}

variable "ami" {
    default     = "ami-7bba5a03"
    description = "Instance AMI ID"
}

variable "key_name" {
    description = "SSH key name in your AWS account for AWS instances"
}

variable "instance_type" {
    default     = "t2.large" # RAM Requirements >= 8gb
    description = "AWS Instance type"
}

variable "root_volume_size" {
    default     = "16"
    description = "Size in GB of the root volume for instances"
}

variable "vpc_cidr" {
    default     = "192.168.199.0/24"
    description = "Subnet in CIDR format to assign to VPC"
}

variable "subnet_cidrs" {
    default     = ["192.168.199.0/26", "192.168.199.64/26", "192.168.199.128/26"]
    description = "Subnet ranges (requires 3 entries)"
}

variable "availability_zones" {
    default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
    description = "Availability zones to place subnets"
}

variable "internal_elb" {
    default     = "false"
    description = "Force the ELB to be internal only"
}

#------------------------------------------#
# Database Variables
#------------------------------------------#
variable "db_name" {
    default     = "rancher"
    description = "Name of the RDS DB"
}

variable "db_user" {
    default     = "rancher"
    description = "Username used to connect to the RDS database"
}

variable "db_pass" {
    description = "Password used to connect to the RDS database"
}

#------------------------------------------#
# SSL Variables
#------------------------------------------#
variable "enable_https" {
    default     = false
    description = "Enable HTTPS termination on the loadbalancer"
}

variable "cert_body" {
    default = ""
}

variable "cert_private_key" {
    default = ""
}

variable "cert_chain" {
    default = ""
}

#------------------------------------------#
# Rancher Variables
#------------------------------------------#
variable "rancher_version" {
    default     = "stable"
    description = "Rancher version to deploy"
}
