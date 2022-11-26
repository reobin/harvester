defmodule Harvester.MixProject do
  use Mix.Project

  def project do
    [
      app: :harvester,
      version: "1.0.0",
      elixir: "~> 1.14",
      deps: [
        {:httpoison, "~> 1.8.2"},
        {:jason, "~> 1.4.0"},
        {:env, "~> 0.2"}
      ],
      aliases: aliases()
    ]
  end

  def application do
    [applications: [:env, :httpoison, :jason]]
  end

  defp aliases do
    ["harvester.run": "run bin/run"]
  end
end
