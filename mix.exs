defmodule CacheUtilityService.MixProject do
  use Mix.Project

  def project do
    [
      app: :cache_utility_service,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        "coveralls.xml": :test
      ],
      deps: deps()
      # dialyzer: [plt_add_apps: [:ex_unit], ignore_warnings: "config/dialyzer.ignore"]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {CacheUtilityService.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.5"},
      {:jason, "~> 1.4"},
      {:inflex, "~> 2.1.0"},

      # Redis
      {:redix, "~> 1.1"},

      # Release
      {:distillery, "~> 2.1"},
      {:config_tuples, "~> 0.4.2"},

      # Testing
      {:mock, "~> 0.3.7", only: :test},

      # Code analysis
      {:excoveralls, "~> 0.15.1", only: :test},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:credo_sonarqube, "~> 0.1.3", only: [:dev, :test]},
      {:ex_unit_sonarqube, "~> 0.1", only: :test},
      {:sobelow, "~> 0.8", only: :dev, runtime: false}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/cache_utility_service/helpers"]
  defp elixirc_paths(_), do: ["lib"]
end
