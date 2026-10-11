variable "kubernetes_automatic_clusters" {
  description = <<EOT
Map of kubernetes_automatic_clusters, attributes below
Required:
    - location
    - name
    - resource_group_name
    - identity (block):
        - identity_ids (optional)
        - type (required)
Optional:
    - tags
    - api_server_access (block):
        - authorized_ip_ranges (optional)
        - subnet_id (optional)
    - hosted_system (block):
        - node_subnet_id (required)
        - system_node_subnet_id (required)
    - private_cluster (block):
        - private_dns_zone_id (optional)
        - public_fully_qualified_domain_name_enabled (optional)
    - service_mesh (block):
        - certificate_authority (optional, block):
            - certificate_chain_object_name (required)
            - certificate_object_name (required)
            - key_object_name (required)
            - key_vault_id (required)
            - root_certificate_object_name (required)
        - external_ingress_gateway_enabled (optional)
        - internal_ingress_gateway_enabled (optional)
        - proxy_redirect_mechanism (optional)
        - revisions (required)
    - web_app_routing_ingress (block):
        - default_nginx_controller (optional)
        - dns_zone_ids (optional)
        - istio_enabled (optional)
EOT

  type = map(object({
    location            = string
    name                = string
    resource_group_name = string
    tags                = optional(map(string))
    identity = object({
      identity_ids = optional(set(string))
      type         = string
    })
    api_server_access = optional(object({
      authorized_ip_ranges = optional(set(string))
      subnet_id            = optional(string)
    }))
    hosted_system = optional(object({
      node_subnet_id        = string
      system_node_subnet_id = string
    }))
    private_cluster = optional(object({
      private_dns_zone_id                        = optional(string)
      public_fully_qualified_domain_name_enabled = optional(bool)
    }))
    service_mesh = optional(object({
      certificate_authority = optional(object({
        certificate_chain_object_name = string
        certificate_object_name       = string
        key_object_name               = string
        key_vault_id                  = string
        root_certificate_object_name  = string
      }))
      external_ingress_gateway_enabled = optional(bool)
      internal_ingress_gateway_enabled = optional(bool)
      proxy_redirect_mechanism         = optional(string)
      revisions                        = list(string)
    }))
    web_app_routing_ingress = optional(object({
      default_nginx_controller = optional(string)
      dns_zone_ids             = optional(list(string))
      istio_enabled            = optional(bool)
    }))
  }))
}

