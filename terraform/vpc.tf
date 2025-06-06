## Por ser um desafio, vou deixar apenas 16 hosts disponíveis
resource "aws_vpc" "vpc" {

  cidr_block           = "10.0.0.0/28"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-principal"
  }
}

## Permitir que a VPC se comunica com a internet publica
resource "aws_internet_gateway" "gw" {

  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "igw-principal"
  }
}

## Criação da subnet publica, neste caso não há a necessidade de criar uma subnet privada
resource "aws_subnet" "subnet_public" {

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.0.0/28"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "subnet-publica-principal"
  }
}

## Para onde vai o tráfego que sai da subnet
resource "aws_route_table" "rt" {

  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "rt-principal"
  }
}

## Associação entre uma subnet e uma route table
resource "aws_route_table_association" "rta" {

  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.rt.id

}

## Liberação das portas 80 e 22
## O ideal seria vincular somente um ip a porta 22, então para não gerar um complexidade para essa POC, optei por deixar publico
resource "aws_security_group" "sg" {
  name        = "sg_principal"
  description = "Liberacao das portas 80 e 22"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
