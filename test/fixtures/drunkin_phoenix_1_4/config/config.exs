# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :drunkin_phoenix,
  ecto_repos: [DrunkinPhoenix.Repo]

# Configures the endpoint
config :drunkin_phoenix, DrunkinPhoenixWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "7/2A3O/b0JM1btoGaSK54GOa9Glb6VB/hNffwMpaHoMFFBbvmj9Y2gZHoMICMwzF",
  render_errors: [view: DrunkinPhoenixWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: DrunkinPhoenix.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
