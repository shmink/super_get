defmodule SuperGet.Application do
  use Application

  def start(_type, _args) do
    repo = [SuperGet.Repo]

    children =
      [
        Plug.Cowboy.child_spec(
          scheme: :http,
          plug: SuperGet,
          options: [port: 4000]
        )
      ] ++ repo

    opts = [strategy: :one_for_one, name: SuperGet.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
