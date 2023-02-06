defmodule CacheUtilityService.EntryPoint.Http.ErrorMapper do
  @moduledoc """
  CacheUtilityService.EntryPoint.Http.ErrorMapper
  """

  require CacheUtilityService.Domain.Error.DomainErrors
  require CacheUtilityService.EntryPoint.Http.HttpErrors

  alias CacheUtilityService.Domain.Error.DomainErrors
  alias CacheUtilityService.EntryPoint.Http.HttpErrors

  def map_error(error, detail \\ nil) do
    {status_code, error_body} = error_info(error)
    {status_code, Map.put(error_body, "detail", detail)}
  end

  defp error_info(HttpErrors.invalid_req_body_code()) do
    {400, %{"code" => "RUS-0001", "message" => "Invalid request body"}}
  end

  defp error_info(HttpErrors.resource_not_found()) do
    {404, %{"code" => "RUS-0002", "message" => "Resource Not Found"}}
  end

  defp error_info(DomainErrors.cache_not_found_error()) do
    {500, %{"code" => "RUS-0003", "message" => "Resource Not Found"}}
  end

  defp error_info(DomainErrors.unknown_key_redis()) do
    {500, %{"code" => "RUS-0004", "message" => "Key Not Found"}}
  end

  defp error_info(DomainErrors.unknown_key_not_exist()) do
    {500, %{"code" => "RUS-0005", "message" => "key not exist"}}
  end

  defp error_info(_) do
    {500, %{"code" => "RUS-0000", "message" => "Generic error"}}
  end

end
