defmodule InstaClone.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      InstaCloneWeb.Telemetry,
      InstaClone.Repo,
      {DNSCluster, query: Application.get_env(:insta_clone, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: InstaClone.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: InstaClone.Finch},
      # Start a worker by calling: InstaClone.Worker.start_link(arg)
      # {InstaClone.Worker, arg},
      # Start to serve requests, typically the last entry
      InstaCloneWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: InstaClone.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    InstaCloneWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
