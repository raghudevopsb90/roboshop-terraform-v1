locals {
  common_tags = {
    project = "roboshop"
    env     = var.environment
  }

  databases = {
    mysql    = { port = 3306 }
    mongodb  = { port = 27017 }
    valkey   = { port = 6379 }
    rabbitmq = { port = 5672 }
  }

  applications = {
    frontend     = { port = 80 }
    catalogue    = { port = 8002 }
    user         = { port = 8001 }
    cart         = { port = 8003 }
    shipping     = { port = 8004 }
    payment      = { port = 8005 }
    notification = { port = 8008 }
    orders       = { port = 8007 }
    ratings      = { port = 8006 }
  }

  components = merge(local.databases, local.applications)
}
