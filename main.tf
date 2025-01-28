provider "aws" {
    region = "ap-south-1"
}

resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "my_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.0.0.0/24"
    map_public_ip_on_launch = true
}

resource "aws_security_group" "ec2_sg" {
    vpc_id = aws_vpc.my_vpc.id

    ingress{
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress{
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "app_server" {
    ami = "ami-0c55b159cbfafe1f0"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.my_subnet.id
    security_groups = [aws_security_group.ec2_sg.name]
    key_name = "my-key-pair"
}

resource "aws_db_instance" "mysql_db" {
    allocated_storage = 20
    engine = "mysql"
    instance_class = "db.t2.micro"
    username = "admin"
    password = "mypassword2025"
    publicly_accessible = false
    vpc_security_group_ids = [aws_security_group.ec2_sg.id]
}

resource "aws_s3_bucket" "app_bucket" {
    bucket = "my-app-bucket"
}

resource "aws_s3_bucket_acl" "app_bucket_acl" {
    bucket = aws_s3_bucket.app_bucket.id
    acl = "private"   
}

