defmodule ServerWeb.UserController do
  use ServerWeb, :controller

  alias Server.{User, Repo}

  def count(conn, _) do
    count = Repo.all(User) |> length()

    conn
    |> put_status(:ok)
    |> render("count.json", data: count)
  end
end
