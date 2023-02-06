defmodule CacheUtilityService.Domain.Ports.CacheGets do
  @moduledoc """
  Domain port to get the user information
  """

  alias CacheUtilityService.Domain.Models.CacheGet

  @callback get_cache(CacheGet.t()) :: {:ok, %{}}  | {:error, atom()}
end
