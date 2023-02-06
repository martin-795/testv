defmodule CacheUtilityService.Adapters.CacheUtilityDel do


  @moduledoc """
  Event repository responsible for communicating to DynamoDB to write event information
  """

  @behaviour CacheUtilityService.Domain.Ports.CacheDel

  require Logger
  require CacheUtilityService.Domain.Error.DomainErrors


  alias CacheUtilityService.Domain.Models.CacheDel
  alias CacheUtilityService.Domain.Error.DomainErrors


  @impl true
  @spec del_cache(CacheDel.t()) :: {:ok, %{}} | {:error, atom()}
  def del_cache(%CacheDel{} = request) do

    {:ok, key} = Map.fetch(request, :key)

    case Redix.command(:redix, ["DEL", key]) do
      {:ok, value} ->
      case value do
        1 ->
          {:ok, %{"key" => key}}
        0 ->
            {:error, DomainErrors.unknown_key_not_exist()}
      end
      _ ->
        {:error, DomainErrors.cache_not_found_error()}
    end
      end
    end
