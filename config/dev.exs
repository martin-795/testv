import Config

# Dependency injection for ports
config :cache_utility_service,
       CacheUtilityService.Domain.Ports.RedisSet,
       adapter: CacheUtilityService.Adapters.CacheUtilitySet

config :cache_utility_service,
       CacheUtilityService.Domain.Ports.CacheGets,
       adapter: CacheUtilityService.Adapters.CacheUtilityGet

config :cache_utility_service,
       CacheUtilityService.Domain.Ports.CacheDel,
       adapter: CacheUtilityService.Adapters.CacheUtilityDel


config :cache_utility_service,
  port: 8083,
  request_id_http_header_name: "request-id"


config :logger, :console, metadata: [:request_id]
