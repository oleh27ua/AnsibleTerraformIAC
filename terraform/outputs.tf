# Output the public IP of the load balancer
output "lb_dns_name" {
  description = "Domain name of the load balancer"
  value       = aws_lb.app_alb.dns_name
}

output "ansible_inventory" {
  value = <<-EOT
    [db]
    ${aws_instance.db.*.private_ip}

    [webservers]
    ${aws_instance.app[*].private_ip}

    [all:vars]
    ansible_user=ec2-user
    ansible_ssh_private_key_file=/home/user/.ssh/ansible-key.pem
    EOT
}