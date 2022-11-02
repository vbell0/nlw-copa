defmodule Server.Helper do
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
end
