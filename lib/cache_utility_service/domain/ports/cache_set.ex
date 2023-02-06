defmodule CacheUtilityService.Domain.Ports.RedisSet do
  @moduledoc """
  Domain port to get the user information
  """

  alias CacheUtilityService.Domain.Models.CacheSet

  @callback set_cache(CacheSet.t()) :: {:ok, %{}}  | {:error, atom()}
end
