defmodule BootlegPhoenix.Mixfile do
  use Mix.Project

  @version "0.1.1"
  @source "https://github.com/labzero/bootleg_phoenix"

  def project do
    [app: :bootleg_phoenix,
     version: @version,
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     elixirc_paths: elixirc_paths(Mix.env),
     docs: [source_ref: "v#{@version}", main: "readme", extras: ["README.md"]],
     test_coverage: [tool: ExCoveralls],
     dialyzer: [plt_add_deps: :transitive, plt_add_apps: [:mix, :sshkit]],
     package: package(),
     description: description(),
   ]
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
      {:bootleg, "~> 0.2.0", runtime: false},
      {:credo, "~> 0.7", only: [:dev, :test]},
      {:dialyxir, "~> 0.5", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.16", only: :dev, runtime: false},
      {:excoveralls, "~> 0.6", only: :test},
      {:mock, "~> 0.2.0", only: :test},
      {:junit_formatter, "~> 1.3", only: :test},
      {:temp, "~> 0.4.3", only: :test}
    ]
  end

  defp description do
    "Provides Phoenix-specific Bootleg tasks."
  end

  defp package do
    [maintainers: ["labzero", "Brien Wankel", "Ned Holets", "Rob Adams"],
     licenses: ["MIT"],
     links: %{
      "GitHub" => @source,
      "Bootleg" => "https://github.com/labzero/bootleg"
    }]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(:dev), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
