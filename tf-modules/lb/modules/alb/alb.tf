module "this" {
  source = "github.com/terraform-aws-modules/terraform-aws-alb.git?ref=v7.0.0"

  create_lb = var.create_lb
  name      = var.name

  load_balancer_type = var.load_balancer_type

  vpc_id = var.vpc_id

  ## only listen on http for this exercise
  /* http_tcp_listeners = concat(var.http_tcp_listeners, []) */

  ## Order of these maps is important and the index of these are to be referenced in listener definitions. Required key/values: name, backend_protocol, backend_port
  /* target_groups = concat(var.target_groups, []) */

  subnets = var.subnets

  security_groups = var.security_groups

  tags = merge(
    var.tags,
    {
      Name = "alb-dmc"
    }
  )
  lb_tags = merge(
    var.lb_tags,
    {
      Name = "alb-dmc"
    }
  )
}
