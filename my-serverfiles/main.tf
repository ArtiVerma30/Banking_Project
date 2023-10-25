resource "aws_instance" "test-server" {
       ami = "ami-0287a05f0ef0e9d9a"
       instance_type = "t2.micro"
       key_name = "Artikeypair"
       vpc_security_group_ids = ["sg-0a8200a8ca7f3abdd"]
       connection {
       	   type		= "ssh"
      	   user		= "ubuntu"
	   private_key	= file("./Artikeypair.pem")
	   host		= self.public_ip
         }
	provisioner "remote-exec" {
		inline = ["echo 'wait to start the instance' "]
	}
	tags = {
	  Name = "test-server"
	}
	provisioner "local-exec" {
		command = "echo ${aws_instance.test-server.public_ip} > inventory "
	}
	provisioner "local-exec" {
		command = "ansible-playbook /var/lib/jenkins/workspace/Banking-Project/target/my-serverfiles/finance-playbook.yml"
	}
}
