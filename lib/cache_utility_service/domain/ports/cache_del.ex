defmodule CacheUtilityService.Domain.Ports.CacheDel do

  alias CacheUtilityService.Domain.Models.CacheDel

  @callback del_cache(CacheDel.t()) :: {:ok, %{}} | {:error, atom()}

end
