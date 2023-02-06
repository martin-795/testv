defmodule CacheUtilityService.Domain.Error.DomainErrors do
  @moduledoc """
  Domain errors.
  This module dathers all the domain errores that can be used.
  Macros allows us to gather them in just one point.
  """
  defmacro cache_not_found_error, do: :cache_not_found_error
  defmacro unknown_key_redis, do: :unknown_user_data_repository_error

  defmacro unknown_key_not_exist, do: :unknown_key_not_exist

end
