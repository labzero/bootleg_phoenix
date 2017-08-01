defmodule DrunkinPhoenix.Mixfile do
  use Mix.Project

  def project do
    [app: :drunkin_phoenix,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:phoenix, "~> 1.2.1"},
      {:phoenix_pubsub, "~> 1.0"},
      {:cowboy, "~> 1.0"},
      {:distillery, "~> 1.4", runtime: false},
      {:bootleg, "~> 0.2.0", runtime: false, override: true},
      {:bootleg_phoenix, ">= 0.0.0", path: System.get_env("BOOTLEG_PHOENIX_PATH"), runtime: false}
    ]
  end
end
