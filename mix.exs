defmodule Talib.Mixfile do
  use Mix.Project

  def project do
    [
      app: :talib,
      version: "0.1.5",
      elixir: "~> 1.10",
      description: "An Elixir Technical Analysis library.",
      package: [
        maintainers: ["Wouter Klijn", "Pavel Ro"],
        licenses: ["MIT"],
        links: %{"GitHub" => "https://github.com/buurzx/talib"}
      ],
      aliases: [
        "test.all": ["test.types", "test"],
        "test.types": ["dialyzer"]
      ],
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  defp deps do
    [{:ok, "~> 2.3"}]
  end
end
