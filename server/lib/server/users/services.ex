defmodule Server.User.Services do
  alias Server.{User, Repo, GoogleApi}

  def create(token) do
    case GoogleApi.get_user_info(token) do
      {:ok, params} ->
        changeset = %{
          name: params["name"],
          email: params["email"],
          google_id: params["id"],
          avatar_url: params["picture"]
        }

        changeset =
          %User{}
          |> User.changeset(changeset)

        case Repo.insert(changeset) do
          {:ok, user} ->
            {:ok, user}

          _ ->
            Repo.get_by(User, google_id: "#{params["id"]}")
            |> case do
              nil -> {:error, "not found user"}
              user -> {:ok, user}
            end
        end

      {:error, error} ->
        {:error, error}
    end
  end

  def get_user(id) do
    Repo.get!(User, id)
  end

  def count(), do: Repo.all(User) |> length()
end
