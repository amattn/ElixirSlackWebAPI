defmodule SlackWeb.Mixfile do
  use Mix.Project

  def project do
    [
      app: :slack_web,
      version: "0.1.3",
      elixir: ">= 1.9.4",
      elixirc_paths: elixirc_paths(Mix.env()),
      name: "SlackWeb",
      deps: deps(),
      docs: docs(),
      package: package(),
      name: "SlackWeb",
      source_url: "https://github.com/amattn/ElixirSlackWebAPI",
      description: "A Slack Web API client"
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.8"},
      {:jason, "~> 1.2.2"},
      {:ex_doc, "~> 0.24.2", only: :dev},
      {:credo, "~> 1.5", only: [:dev, :test]},
      {:plug_cowboy, "~> 2.5"}
    ]
  end

  def docs do
    [
      {:main, Slack},
      {:assets, "guides/assets"},
      {:extra_section, "GUIDES"},
      {:extras, ["guides/token_generation_instructions.md"]}
    ]
  end

  defp package do
    %{
      name: "slack_web",
      maintainers: ["amattn"],
      licenses: ["MIT"],
      links: %{
        Github: "https://github.com/amattn/ElixirSlackWebAPI",
        Documentation: "https://hexdocs.pm/slack_web/"
      }
    }
  end
end
