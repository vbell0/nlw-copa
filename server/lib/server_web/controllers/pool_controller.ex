defmodule ServerWeb.PoolController do
  use ServerWeb, :controller

  alias Server.Pools.Services

  def create(conn, %{"title" => title}) do
    case Services.create(title) do
      {:ok, pool} ->
        conn
        |> put_status(:created)
        |> render("create.json", data: pool)

      {:error, _pool} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json", errors: "Error title length min 4 words")
    end
  end

  def count(conn, _) do
    count = Services.count()

    conn
    |> put_status(:ok)
    |> render("count.json", data: count)
  end
end
