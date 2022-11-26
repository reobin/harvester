defmodule Harvester.MixProject do
  use Mix.Project

  def project do
    [
      app: :harvester,
      version: "1.0.0",
      elixir: "~> 1.14",
      deps: [
        {:dotenv, "~> 3.0.0"},
        {:httpoison, "~> 1.8.2"},
        {:jason, "~> 1.4.0"}
      ],
      aliases: aliases()
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp aliases do
    [
      "harvester.run": "run bin/run"
    ]
  end
end
