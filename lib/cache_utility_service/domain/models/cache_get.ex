defmodule CacheUtilityService.Domain.Models.CacheGet do
  @moduledoc """
  Event data struct
  """

  use CacheUtilityService.Utils.JsonMapper

  alias CacheUtilityService.Utils.ValueValidators

  require Logger

  @type t :: %__MODULE__{
          key: String.t()
        }

  @required_input_properties [
    "key"
  ]

  defstruct [
    :key
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

     %__MODULE__{
      key: key
     }
  end
end
