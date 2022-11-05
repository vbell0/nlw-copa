defmodule Server.Helper do
  import Plug.Conn
  alias Ecto.Changeset
  @full_chars "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz123456789" |> String.split("")

  def gen_code() do
    Enum.reduce(1..6, [], fn _i, acc ->
      char = Enum.random(@full_chars)

      if char != "" do
        [char | acc]
      else
        ["S" | acc]
      end
    end)
    |> Enum.join("")
  end

  def uuid_validate(changeset, uuid) do
    Ecto.UUID.cast(uuid)
    |> case do
      {:ok, uuid} -> uuid
      :error -> Changeset.add_error(changeset, :owner_id, "Invalid uuid format")
    end
  end

  def uuid_check(uuid) do
    Ecto.UUID.cast(uuid)
    |> case do
      {:ok, uuid} -> uuid
      :error -> raise "Invalide uuid format"
    end
  end

  def get_token_from_header(conn) do
    get_req_header(conn, "authorization")
    |> case do
      [] ->
        conn |> not_autorization()

      header ->
        token =
          header
          |> List.first()
          |> String.split()
          |> validate_token(conn)

        token
    end
  end

  defp validate_token(auth, _conn) when length(auth) === 2, do: List.last(auth)
  defp validate_token(_, conn), do: conn |> not_autorization()

  def not_autorization(conn) do
    conn |> send_resp(401, Jason.encode!(%{error: "Not authorization"}))
  end
end
