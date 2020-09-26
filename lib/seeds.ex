defmodule SuperGet.Seeds do
  alias SuperGet.{Repo, User}

  def add_default_users(users) do
    users |> Enum.map(&Repo.insert(&1))
  end

  def default_users do
    [
      %User{
        name: "Tom",
        location: "Birmingham",
        occupation: "Dev"
      },
      %User{
        name: "James",
        location: "London",
        occupation: "Barber"
      },
      %User{
        name: "Anthony",
        location: "Bristol",
        occupation: "Muscian"
      },
      %User{
        name: "Alex",
        location: "Manchester",
        occupation: "Director"
      },
      %User{
        name: "Angela",
        location: "Solihull",
        occupation: "Dev"
      },
      %User{
        name: "Debra",
        location: "London",
        occupation: "Dev"
      },
      %User{
        name: "Paul",
        location: "Manchester",
        occupation: "Dev"
      }
    ]
  end
end
