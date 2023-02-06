defmodule CacheUtilityService.Config.ModuleInyector do
  @moduledoc """
    Module inyector intended to achieve dependency injection at compile time
  """
  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      ports_and_adapters = CacheUtilityService.Config.ModuleInyector.parse_modules(opts)

      Enum.each(ports_and_adapters, fn {port, adapter} ->
        def adapter_for(unquote(port)), do: unquote(adapter)
      end)

      def adapter_for(invalid_port) do
        raise "Module for #{inspect(invalid_port)} port was not inyected. Make sure you passed the port during in the options"
      end
    end
  end

  def parse_modules(opts \\ []) when is_list(opts) do
    unless length(opts) > 0 do
      raise "At least one port is required"
    end

    Stream.map(opts, fn
      {port, adapter} -> {port, adapter}
      port -> {port, load_module_for_port(port)}
    end)
  end

  defp load_module_for_port(port) do
    IO.puts("Loading module for port #{inspect(port)}")
    adapter_config = Application.get_env(:cache_utility_service, port)

    case adapter_config[:adapter] do
      nil ->
        raise "Adapter for port #{inspect(port)} not found in config file. Make sure it is configured correctly"

      adapter_module ->
        adapter_module
    end
  end
end
