defmodule CacheUtilityService.Domain.UseCases.DelUseCase do
    @moduledoc """
      Domain module intended to gather all business logic regarding get user use case
    """
    use CacheUtilityService.Config.ModuleInyector, [
      CacheUtilityService.Domain.Ports.CacheDel
    ]

    alias CacheUtilityService.Domain.Models.CacheDel
    alias CacheUtilityService.Domain.Ports.CacheDel

    @spec handle(CacheUtilityService.Domain.Models.CacheDel.t()) :: {:ok, %{}} | {:error, atom()}
    def handle(encode_body), do: adapter_for(CacheDel).del_cache(encode_body)

end
