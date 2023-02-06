defmodule CacheUtilityService.Utils.ValueValidators do
  @moduledoc """
     CacheUtilityService.Utils.ValueValidators
     Util module to validate types
  """

  def validate_string_or_nil(validator_errors, _value_name, value)
      when is_list(validator_errors) and is_binary(value),
      do: validator_errors

  def validate_string_or_nil(validator_errors, _value_name, nil) when is_list(validator_errors),
    do: validator_errors

  def validate_string_or_nil(validator_errors, value_name, _value) when is_list(validator_errors),
    do: ["#{value_name} should be a string or null" | validator_errors]

  def validate_non_emptry_string(validator_errors, value_name, value)
      when is_list(validator_errors) and is_binary(value) do
    case String.length(value) do
      0 -> ["Invalid value for #{value_name}" | validator_errors]
      _ -> validator_errors
    end
  end

  def validate_non_emptry_string(validator_errors, value_name, _value)
      when is_list(validator_errors) do
    ["Invalid value type for #{value_name}" | validator_errors]
  end

  def validate_number(validator_errors, _value_name, value)
      when is_list(validator_errors) and is_number(value),
      do: validator_errors

  def validate_number(validator_errors, value_name, _value) when is_list(validator_errors),
    do: ["#{value_name} is not a number" | validator_errors]

  def validate_non_negative_number(validator_errors, value_name, value)
      when is_list(validator_errors) do
    num_validation = validate_number(validator_errors, value_name, value)

    case num_validation do
      ^validator_errors ->
        if value <= 0,
          do: ["#{value_name} should be non negative" | validator_errors],
          else: validator_errors

      new_validation_errors ->
        new_validation_errors
    end
  end

  def validate_negative_number(validator_errors, value_name, value)
      when is_list(validator_errors) do
    num_validation = validate_number(validator_errors, value_name, value)

    case num_validation do
      ^validator_errors ->
        if value >= 0,
          do: ["#{value_name} should be negative" | validator_errors],
          else: validator_errors

      new_validation_errors ->
        new_validation_errors
    end
  end

  def validate_list(validator_errors, _value_name, value)
      when is_list(validator_errors) and is_list(value),
      do: validator_errors

  def validate_list(validator_errors, value_name, _value) when is_list(validator_errors),
    do: ["#{value_name} is not a list" | validator_errors]

  def validate_required_properties(
        %{} = input_value_map,
        required_properties,
        key_prefix_for_missing_key \\ ""
      ) do
    Enum.reduce(
      required_properties,
      [],
      fn property_name, acc ->
        case Map.has_key?(input_value_map, property_name) do
          true ->
            acc

          false ->
            ["#{key_prefix_for_missing_key}#{property_name} is required" | acc]
        end
      end
    )
  end
end
