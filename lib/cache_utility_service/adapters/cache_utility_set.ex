defmodule CacheUtilityService.Adapters.CacheUtilitySet do
  @moduledoc """
  Event repository responsible for communicating to DynamoDB to write event information
  """

  @behaviour CacheUtilityService.Domain.Ports.RedisSet

  require Logger
  require CacheUtilityService.Domain.Error.DomainErrors

  alias CacheUtilityService.Domain.Models.CacheSet
  alias CacheUtilityService.Domain.Error.DomainErrors


  @impl true
  @spec set_cache(CacheSet.t()) :: {:ok, %{}} | {:error, atom()}
  def set_cache(%CacheSet{} = request) do

    {:ok, key} = Map.fetch(request, :key)
    {:ok, value} = Map.fetch(request, :value)
    {:ok, ttl} = Map.fetch(request, :ttl)
    {:ok, encode} = Jason.encode(value)

    case Redix.command(:redix, ["SETEX", key , ttl , encode]) do
      {:ok, _} ->
        {:ok, value}
      _ ->
        {:error, DomainErrors.cache_not_found_error()}
    end
  end
end
