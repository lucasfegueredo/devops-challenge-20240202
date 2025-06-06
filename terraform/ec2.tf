## Criação do EC2 com um script prévio que atualiza o ubunto e habilita o nginx
## a chave ssh foi previamente criada
resource "aws_instance" "ubuntu" {
  ami                    = "ami-0c7217cdde317cfec" # Ubuntu 22.04 LTS us-east-1
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.subnet_public.id
  vpc_security_group_ids = [aws_security_group.sg.id]
  key_name               = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install nginx git -y
              systemctl enable nginx && systemctl start nginx
              EOF

  tags = {
    Name = "ec2-ubuntu-principal"
  }
}

output "public_ip" {
  value = aws_instance.ubuntu.public_ip
}