defmodule SuperGet.Repo do
  use Ecto.Repo,
    otp_app: :super_get,
    adapter: Ecto.Adapters.Postgres
end
