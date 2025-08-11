defmodule Slax.MixProject do
  use Mix.Project

  def project do
    [
      app: :slax,
      version: "0.1.0",
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      listeners: [Phoenix.CodeReloader]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Slax.Application, []},
      extra_applications: [:logger, :runtime_tools, :os_mon]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.8.0-rc.0", override: true},
      {:phoenix_html, ">= 0.0.0"},
      {:phoenix_ecto, "~> 4.6"},
      {:phoenix_live_reload, ">= 0.0.0", only: :dev},
      {:phoenix_live_view, "~> 1.0.0"},
      {:phoenix_live_dashboard, ">= 0.0.0"},

      {:unicode_util_compat, "~> 0.7", override: true},
      {:mimerl, "~> 1.3", override: true},
      {:certifi, "~> 2.12", override: true},
      {:ecto_sql, "~> 3.10"},
      {:postgrex, ">= 0.0.0"},
      # {:phoenix_view, ">= 0.0.0"},
      {:bcrypt_elixir, "~> 3.0"},
      {:floki, ">= 0.30.0", only: :test},
      {:esbuild, "~> 0.9", runtime: Mix.env() == :dev},
      {:tailwind, "~> 0.2", runtime: Mix.env() == :dev},
      {:heroicons,
       github: "tailwindlabs/heroicons",
       tag: "v2.1.1",
       sparse: "optimized",
       app: false,
       compile: false,
       depth: 1},
      {:swoosh, "~> 1.5"},
      {:finch, "~> 0.13"},
      {:telemetry_metrics, "~> 1.0"},
      {:telemetry_poller, "~> 1.0"},
      {:gettext, "~> 0.20"},
      {:jason, "~> 1.2"},
      {:dns_cluster, "~> 0.1.1"},
      {:plug, "~> 1.18", override: true},
      {:bandit, "~> 1.6"},
      {:timex, "~> 3.7"},
      {:ecto_psql_extras, "~> 0.8"},
      {:opentelemetry, "~> 1.5"},
      # For exporting traces
      {:opentelemetry_exporter, "~> 1.8"},
      # Phoenix instrumentation
      {:opentelemetry_phoenix, "~> 2.0"},
      # Ecto instrumentation (if using Ecto)
      {:opentelemetry_ecto, "~> 1.2"},
      # Bandit adapter for the Phoenix instrumentation
      {:opentelemetry_bandit, "~> 0.2"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "assets.setup", "assets.build"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.setup": ["tailwind.install --if-missing", "esbuild.install --if-missing"],
      "assets.build": ["tailwind slax", "esbuild slax"],
      "assets.deploy": [
        "tailwind slax --minify",
        "esbuild slax --minify",
        "phx.digest"
      ]
    ]
  end
end
