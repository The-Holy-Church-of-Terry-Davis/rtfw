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
      extra_applications: [:logger, :nostrum],
      mod: {Rtfw.Application, []}
    ]
  end

  defp deps do
    [
      {:nostrum, "~> 0.10"}
    ]
  end
end
