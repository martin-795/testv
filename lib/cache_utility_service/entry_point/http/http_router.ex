defmodule CacheUtilityService.EntryPoint.Http.HttpRouter do
  @moduledoc """
    HTTP ROUTER: it is exposed by cowboy using a http server.
  """
  use Plug.Router
  use Plug.ErrorHandler

  require Logger
  require CacheUtilityService.EntryPoint.Http.HttpErrors

  alias CacheUtilityService.Config.AppConfig
  alias CacheUtilityService.Domain.Models.{ CacheSet, CacheRes, CacheGet, CacheDel }
  alias CacheUtilityService.Domain.UseCases.{ GetUseCase, SetUseCase, DelUseCase }
  alias CacheUtilityService.EntryPoint.Http.{ HttpErrors, ErrorMapper}


  @request_id_http_header_name AppConfig.request_id_http_header_name()

  plug(Plug.RequestId, http_header: @request_id_http_header_name)

  plug(Plug.Logger)

  plug(:match)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  )

  plug(:dispatch)

  post "/set" do
    {status_code, resp} =
      with {:new, {:ok, %CacheSet{} = set_body}} <- {:new, CacheSet.new(conn.body_params)},
      {:ok, %{} = res} <- SetUseCase.handle(set_body) do
        {201, res}
      else
        {:new, {:error, reason}} ->
          ErrorMapper.map_error(HttpErrors.invalid_req_body_code(), reason)

        {:error, reason} ->
          ErrorMapper.map_error(reason)
      end

    send_response(conn, status_code, resp)
  end

  post "/get" do
    {status_code, resp} =
      with {:new, {:ok, %CacheGet{} = get_body}} <- {:new, CacheGet.new(conn.body_params)},
      {:ok, %{} = res} <- GetUseCase.handle(get_body) do
        {201, res}
      else
        {:new, {:error, reason}} ->
          ErrorMapper.map_error(HttpErrors.invalid_req_body_code(), reason)

        {:error, reason} ->
          ErrorMapper.map_error(reason)
      end

    send_response(conn, status_code, resp)
  end

  post "/del" do
    {status_code, resp} =
      with {:new, {:ok, %CacheDel{} = del_body}} <- {:new, CacheDel.new(conn.body_params)},
      {:ok, %{} = res} <- DelUseCase.handle(del_body)  do
        {201, res}
      else
        {:new, {:error, reason}} ->
          ErrorMapper.map_error(HttpErrors.invalid_req_body_code(), reason)

        {:error, reason} ->
          ErrorMapper.map_error(reason)
      end

    send_response(conn, status_code, resp)
  end

  # Health check route
  get "/health" do
    send_response(conn, 200, %{health: "OK"})
  end

  # Not matched paths
  match _ do
    {status, resp} = ErrorMapper.map_error(HttpErrors.resource_not_found())
    send_response(conn, status, resp)
  end

  @impl Plug.ErrorHandler
  def handle_errors(conn, %{kind: _kind, reason: reason, stack: _stack}) do
    Logger.error("Unhandled error in event utility service",
      error_code: HttpErrors.generic_error(),
      error_info: "#{inspect(reason)}",
      module: __MODULE__
    )

    {status, resp} = ErrorMapper.map_error(HttpErrors.generic_error())

    send_response(conn, status, resp)
  end

  defp send_response(conn, status, resp) do
    conn |> put_resp_content_type("application/json") |> send_resp(status, Jason.encode!(resp))
  end
end
