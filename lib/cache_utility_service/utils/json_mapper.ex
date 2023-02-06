defmodule CacheUtilityService.Utils.JsonMapper do
  @moduledoc """
  CacheUtilityService.Utils.JsonMapper
  """

  defmacro __using__(_opts) do
    quote location: :keep do
      IO.puts("From json mapper __MODULE__ value -> #{inspect(__MODULE__)}")

      def to_json_map(struct, options \\ []) when is_struct(struct) do
        keys_option = options[:keys_option] || :lower
        replacements = options[:replacements] || []
        include_null_values = options[:include_null] || false
        map = Map.from_struct(struct)

        Enum.reduce(replacements, map, fn {key_to_replace, key_replacement}, acc ->
          {value, modified_map} = Map.pop(acc, key_to_replace)
          Map.put(modified_map, key_replacement, value)
        end)
        |> Enum.reduce(%{}, fn
          {key, nil}, acc ->
            nil_value_handler(acc, key, include_null_values, keys_option)

          {key, value}, acc when is_atom(key) ->
            Map.put(acc, format_key(key, keys_option), decode_value(value))

          {key, value}, acc ->
            Map.put(acc, key, decode_value(value))
        end)
      end

      defp decode_value(value) when is_struct(value), do: to_json_map(value)

      defp decode_value(value), do: value

      defp nil_value_handler(map, key, true, keys_option) when is_atom(key),
        do: Map.put(map, format_key(key, keys_option), nil)

      defp nil_value_handler(map, key, true, _keys_option), do: Map.put(map, key, nil)

      defp nil_value_handler(map, _key, false, _keys_options), do: map

      defp format_key(key, keys_option) do
        case keys_option do
          :underscore -> Inflex.underscore(key)
          opt -> Inflex.camelize(key, opt)
        end
      end
    end
  end
end
