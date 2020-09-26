defmodule SuperGet.User do
  use Ecto.Schema
  import Ecto.{Changeset, Query}

  alias __MODULE__
  alias SuperGet.Repo

  schema "users" do
    field(:name, :string)
    field(:location, :string)
    field(:occupation, :string)

    timestamps()
  end

  @valid_attributes [
    :name,
    :location,
    :occupation
  ]

  @required_attribures [
    :name
  ]

  def changeset(%User{} = user, params \\ %{}) do
    user
    |> cast(params, @valid_attributes)
    |> validate_required(@required_attribures)
  end

  def fetch([search, sort]) do
    User
    |> where(^search)
    |> order_by(^sort)
    |> Repo.all()
  end

  def get(id: id), do: get(%{id: id})
  def get(%{id: id}), do: Repo.get(User, id)
end
