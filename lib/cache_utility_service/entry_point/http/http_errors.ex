defmodule CacheUtilityService.EntryPoint.Http.HttpErrors do
  @moduledoc """
  Http errors.
  This module dathers http errores that http entrypoint can use.
  Macros allows us to gather them in just one point.
  """
  defmacro invalid_req_body_code, do: :invalid_req_body_code
  defmacro resource_not_found, do: :resource_not_found
  defmacro generic_error, do: :generic_error
end
