defmodule Rtfw.MixProject do
  use Mix.Project

  def project do
    [
      app: :rtfw,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Rtfw.Application, []}
    ]
  end

  defp deps do
    [
      {:req, "~> 0.5.0"},      # https://hexdocs.pm/req
      {:jason, "~> 1.4"},      # https://hexdocs.pm/jason
      {:websockex, "~> 0.4.3"} # https://hexdocs.pm/websockex
    ]
  end
end
