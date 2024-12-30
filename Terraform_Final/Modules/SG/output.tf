output "http_sg_id" {
  value = aws_security_group.http_sg.id
}
output "ssh_sg_id" {
  value = aws_security_group.ssh_sg.id
}

output "ssh_sg_webservers_id" {
  value = aws_security_group.ssh_webservers_sg.id
}