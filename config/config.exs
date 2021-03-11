# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :tetris_game,
  ecto_repos: [TetrisGame.Repo]

# Configures the endpoint
config :tetris_game, TetrisGameWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "zc9n7hkTxOA/a60RxQV2gOkoFXjdnWjFn+3UFW0MejkLwDOpYeRlT4qDRO0glAkD",
  render_errors: [view: TetrisGameWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: TetrisGame.PubSub,
  live_view: [signing_salt: "UDgbqzY8"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
