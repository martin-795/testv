import Config


# Dependency injection for ports
config :cache_utility_service,
       CacheUtilityService.Domain.Ports.Redis,
       adapter:  CacheUtilityService.Test.Helpers.Adapters.EventRepository


config :cache_utility_service,
  port: 8083,
  request_id_http_header_name: "request-id"
