defmodule CacheUtilityService.Adapters.CacheUtilityGet do
  @moduledoc """
  Event repository responsible for communicating to DynamoDB to write event information
  """

  @behaviour CacheUtilityService.Domain.Ports.CacheGets

  require Logger
  require CacheUtilityService.Domain.Error.DomainErrors

  alias CacheUtilityService.Domain.Models.CacheGet
  alias CacheUtilityService.Domain.Error.DomainErrors

  @impl true
  @spec get_cache(CacheGet.t()) :: {:ok, %{}} | {:error, atom()}
  def get_cache(%CacheGet{} = request) do

    {:ok, key} = Map.fetch(request, :key)

    case Redix.command(:redix, ["GET", key]) do
      {:ok, result} ->
        if result != nil do
          {:ok, decode} = Jason.decode(result)
          {:ok, decode}
        else
          {:error, DomainErrors.unknown_key_redis()}
        end
      _ ->
          {:error, DomainErrors.cache_not_found_error()}
    end
  end
end
