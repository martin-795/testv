defmodule CacheUtilityService.Domain.UseCases.GetUseCase do
  @moduledoc """
    Domain module intended to gather all business logic regarding get user use case
  """
  use CacheUtilityService.Config.ModuleInyector, [
    CacheUtilityService.Domain.Ports.CacheGets
  ]

  alias CacheUtilityService.Domain.Models.CacheGet
  alias CacheUtilityService.Domain.Ports.CacheGets

  @spec handle(CacheGet.t()) :: {:ok, %{}} | {:error, atom()}
  def handle(encode_body), do: adapter_for(CacheGets).get_cache(encode_body)
end
