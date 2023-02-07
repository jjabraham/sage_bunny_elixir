defmodule SageBunnyElixir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {
        Plug.Cowboy,
        scheme: :http,
        plug: SageBunnyElixir.Router,
        options: [port: Application.get_env(:sage_bunny_elixir, :port)]
      },
      {
        Mongo,
        [
          name: :mongo,
          database: Application.get_env(:sage_bunny_elixir, :database),
          pool_size: Application.get_env(:sage_bunny_elixir, :pool_size)
        ]
      }
      # Starts a worker by calling: SageBunnyElixir.Worker.start_link(arg)
      # {SageBunnyElixir.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SageBunnyElixir.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
