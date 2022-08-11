output "lb_id" {
  description = "The ID and ARN of the load balancer we created."
  value       = this.lb_id
}

output "lb_arn" {
  description = "The ID and ARN of the load balancer we created."
  value       = this.lb_arn
}

output "lb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = this.lb_dns_name
}

output "http_tcp_listener_arns" {
  description = "The ARN of the TCP and HTTP load balancer listeners created."
  value       = this.http_tcp_listener_arns
}

output "http_tcp_listener_ids" {
  description = "The IDs of the TCP and HTTP load balancer listeners created."
  value       = this.http_tcp_listener_ids
}


