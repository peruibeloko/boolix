defmodule Boolix.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BoolixWeb.Telemetry,
      Boolix.Repo,
      {DNSCluster, query: Application.get_env(:boolix, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Boolix.PubSub},
      # Start a worker by calling: Boolix.Worker.start_link(arg)
      # {Boolix.Worker, arg},
      # Start to serve requests, typically the last entry
      BoolixWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Boolix.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BoolixWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
