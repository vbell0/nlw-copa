# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :server,
  ecto_repos: [Server.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :server, ServerWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: ServerWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Server.PubSub,
  live_view: [signing_salt: "pnb6sPB6"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Tesla adapter
config :tesla, adapter: Tesla.Adapter.Hackney

config :joken,
  default_signer: "yNE8N4FbMjcnLR87sgeD7PUt5hso6a5iDgRNItYvZv4uggC8WUrGcQhU71TDCWii"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
