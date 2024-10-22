output arn {
 value = aws_instance.web.arn
}


output public_ip {
 value = aws_instance.web.public_ip
}


output private_ip {
 value = aws_instance.web.private_ip
}

output dns_name {
  value = module.alb.dns_name
}

output id {
  value = module.alb.id
}