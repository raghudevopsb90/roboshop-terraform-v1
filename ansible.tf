resource "null_resource" "databases" {
  for_each = local.databases

  triggers = {
    instance_id = aws_instance.databases[each.key].id
    private_ip  = aws_instance.databases[each.key].private_ip
    dns_name    = aws_route53_record.databases[each.key].fqdn
  }

  connection {
    type     = "ssh"
    user     = var.ansible_user
    password = var.ansible_password
    host     = aws_instance.databases[each.key].public_ip
    timeout  = "15m"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo dnf install python3.13-pip -y",
      "sudo pip3.13 install ansible",
      "ansible-pull -i localhost, -e ansible_user=${var.ansible_user} -e ansible_password='${var.ansible_password}' -U https://github.com/raghudevopsb90/roboshop-ansible-v4-with-opencode.git roboshop.yml -e component_name=${each.key}",
    ]
  }
}

resource "null_resource" "applications" {
  for_each = local.applications

  triggers = {
    instance_id = aws_instance.applications[each.key].id
    private_ip  = aws_instance.applications[each.key].private_ip
    dns_name    = aws_route53_record.applications[each.key].fqdn
    databases   = join(",", [for name in sort(keys(local.databases)) : null_resource.databases[name].id])
  }

  connection {
    type     = "ssh"
    user     = var.ansible_user
    password = var.ansible_password
    host     = aws_instance.applications[each.key].public_ip
    timeout  = "15m"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo dnf install python3.13-pip -y",
      "sudo pip3.13 install ansible",
      "ansible-pull -i localhost, -e ansible_user=${var.ansible_user} -e ansible_password='${var.ansible_password}' -U https://github.com/raghudevopsb90/roboshop-ansible-v4-with-opencode.git roboshop.yml -e component_name=${each.key}",
    ]
  }
}
