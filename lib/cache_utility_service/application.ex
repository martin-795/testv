defmodule CacheUtilityService.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false
  use Application

  require Logger

  alias CacheUtilityService.EntryPoint.Http.HttpRouter

  @impl true
  def start(_type, _args) do
    port = Application.get_env(:cache_utility_service, :port, 8083)
    Logger.info("About to run app on port #{port}")

    children = [
      {
        Plug.Cowboy,
        scheme: :http, plug: HttpRouter, options: [port: port]
      },
      {Redix, {"redis://localhost:6379/3", [name: :redix]}}
    ]

    opts = [strategy: :one_for_one, name: CacheUtilityService.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
