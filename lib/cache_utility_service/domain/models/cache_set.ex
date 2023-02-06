defmodule CacheUtilityService.Domain.Models.CacheSet do

  use CacheUtilityService.Utils.JsonMapper

  alias CacheUtilityService.Utils.ValueValidators

  require Logger

  @type t :: %__MODULE__{
          key: String.t(),
          value: map(),
          ttl: integer()
        }

  @required_input_properties [
    "key",
    "value",
    "ttl"
  ]

  defstruct [
    :key,
    :value,
    :ttl
  ]

  def new(%{} = input_value_map) do
    with  [] <-
           ValueValidators.validate_required_properties(
             input_value_map,
             @required_input_properties
           ) do
      {:ok, to_model(input_value_map)}
    else
      errors ->
        {:error, errors}
    end
  end

  def to_model(%{} = map) do
    key = Map.get(map, "key", nil)
    value = Map.get(map, "value", nil)
    ttl = Map.get(map, "ttl", nil)

     %__MODULE__{
      key: key,
      value: value,
      ttl: ttl
     }
  end
end
