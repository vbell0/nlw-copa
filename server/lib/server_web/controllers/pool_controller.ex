defmodule ServerWeb.PoolController do
  use ServerWeb, :controller

  alias Server.{User, Helper, Pool, Repo}

  def create(conn, %{"title" => title}) do
    changeset =
      Pool.changeset(
        %Pool{},
        %{title: title, code: Helper.gen_code() |> String.upcase()},
        %User{}
      )

    case Repo.insert(changeset) do
      {:ok, pool} ->
        conn
        |> put_status(:created)
        |> render("create.json", data: pool)

      {:error, _changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json", errors: "Error title length min 4 words")
    end
  end

  def count(conn, _) do
    count = Repo.all(Pool) |> length()

    conn
    |> put_status(:ok)
    |> render("count.json", data: count)
  end
end
