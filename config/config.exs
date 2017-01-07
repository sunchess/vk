# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :vg,
  ecto_repos: [Vg.Repo]

# Configures the endpoint
config :vg, Vg.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "A9C87i4o1qK9fWHjeIjSv/HhJWHS8aC0hGuMN7BccBNc00CdTIcKsCwFSoDK4Xqx",
  render_errors: [view: Vg.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Vg.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

#Guardian
config :guardian, Guardian,
  issuer: "Ppush.#{Mix.env}",
  ttl: {30, :days},
  verify_issuer: true,
  serializer: Vg.GuardianSerializer,
  secret_key: "A9C87i4o1qK9fWHjeIjSv/HhJWHS8aC0hGuMN7BccBNc00CdTIcKsCwFSoDK4Xqx"
  #permissions: %{
  #  default: [
  #    :read_profile,
  #    :write_profile,
  #    :read_token,
  #    :revoke_token,
  #  ],
  }

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
