defmodule CacheUtilityService.Domain.UseCases.SetUseCase do
  @moduledoc """
    Domain module intended to gather all business logic regarding get user use case
  """
  use CacheUtilityService.Config.ModuleInyector, [
    CacheUtilityService.Domain.Ports.RedisSet
  ]

  alias CacheUtilityService.Domain.Models.CacheSet
  alias CacheUtilityService.Domain.Ports.RedisSet

  @spec handle(CacheSet.t()) :: {:ok, %{}} | {:error, atom()}
  def handle(encode_body), do: adapter_for(RedisSet).set_cache.(encode_body)
end
