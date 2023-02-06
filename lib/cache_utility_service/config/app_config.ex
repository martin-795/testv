defmodule CacheUtilityService.Config.AppConfig do
  @moduledoc """
    Config Util module intended to centralize all the work related to app configuration.
  """
  require Logger

  def request_id_http_header_name() do
    Application.get_env(:cache_utility_service, :request_id_http_header_name, "request-id")
  end
end
