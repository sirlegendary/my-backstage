// Instance Pupblic IPv4
output "ssh_login" {
  value = aws_instance.backstage_vm[*].public_ip
}