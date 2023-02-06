import Config

# Dependency injection for ports
config :cache_utility_service,
       CacheUtilityService.Domain.Ports.Redis,
       adapter: CacheUtilityService.Adapters.Repositories.Event.EventRepository


config :cache_utility_service,
       # Cowboy http port
       port: {:system, "EUS_APP_PORT", default: 8083, type: :integer},
       request_id_http_header_name: {:system, "EUS_REQUEST_ID_HTTP_HEADER_NAME",  default: "request-id", type: :string}


config :logger, :console, metadata: [:request_id]
