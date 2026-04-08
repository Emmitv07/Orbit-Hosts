defmodule OrbitHosts.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      OrbitHostsWeb.Telemetry,
      OrbitHosts.Repo,
      {DNSCluster, query: Application.get_env(:orbit_hosts, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: OrbitHosts.PubSub},
      # Start a worker by calling: OrbitHosts.Worker.start_link(arg)
      # {OrbitHosts.Worker, arg},
      # Start to serve requests, typically the last entry
      OrbitHostsWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: OrbitHosts.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    OrbitHostsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
