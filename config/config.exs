import Config

config :super_get, ecto_repos: [SuperGet.Repo]

config :super_get, SuperGet.Repo,
  database: "users",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
