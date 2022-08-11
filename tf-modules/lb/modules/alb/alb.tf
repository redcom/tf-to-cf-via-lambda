module "this" {
  source = "git://github.com:terraform-aws-modules/terraform-aws-modules/alb/aws?v=7.0.0"

  create_lb = var.create_lb
  name      = var.name

  load_balancer_type = var.load_balancer_type

  vpc_id          = var.vpc_id
  subnets         = var.subnets
  security_groups = var.security_groups

  ## only listen on http for this exercise
  http_tcp_listeners = concat([], var.http_tcp_listeners)

  tags = merge(
    {
      Name = "alb-dmc"
    },
    var.tags
  )
  lb_tags = merge(
    {
      Name = "alb-dmc"
    },
    var.lb_tags
  )
}
