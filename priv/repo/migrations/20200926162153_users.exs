defmodule SuperGet.Repo.Migrations.User do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:name, :string)
      add(:location, :string)
      add(:occupation, :string)

      timestamps()
    end
  end
end
