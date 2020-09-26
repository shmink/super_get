defmodule SuperGet do
  use Plug.Router
  alias SuperGet.User

  plug(Plug.Logger)
  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Jason)
  plug(:dispatch)

  get "/user/:id" do
    user = User.get(id: id)

    case user do
      %{} -> send_resp(conn, 200, struct_to_json(user))
      nil -> send_resp(conn, 404, "Not found")
      _ -> send_resp(conn, 400, "Bad request")
    end
  end

  get "/users" do
    params = parse_params(conn.params)

    resp = User.fetch(params) |> struct_to_json()
    send_resp(conn, 200, resp)
  end

  get "/ping" do
    send_resp(conn, 200, "pong!")
  end

  match _ do
    send_resp(conn, 404, "oops... Nothing here :(")
  end

  defp struct_to_json(structs) when is_list(structs) do
    Enum.map(structs, &struct_to_map/1) |> Jason.encode!()
  end

  defp struct_to_json(%{} = struct) do
    struct |> struct_to_map() |> Jason.encode!()
  end

  defp struct_to_map(%{} = struct) do
    struct
    |> Map.from_struct()
    |> Map.drop([:__meta__])
  end

  defp parse_params(%{} = params) do
    sort = parse_sort_params(params)

    IO.inspect(sort)

    params = Map.delete(params, "asc")
    params = Map.delete(params, "desc")

    search = for {key, val} <- params, into: [], do: {String.to_atom(key), val}

    [search, sort]
  end

  defp parse_sort_params(%{} = params, result \\ []) do
    case params do
      %{"asc" => val} ->
        parse_sort_params(Map.delete(params, "asc"), result ++ [{:asc, String.to_atom(val)}])

      %{"desc" => val} ->
        parse_sort_params(Map.delete(params, "desc"), result ++ [{:desc, String.to_atom(val)}])

      _ ->
        result
    end
  end
end
