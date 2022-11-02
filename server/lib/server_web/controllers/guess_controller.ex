defmodule ServerWeb.GuessController do
  use ServerWeb, :controller

  alias Server.{Repo, Guess}

  def count(conn, _) do
    count = Repo.all(Guess) |> length()

    conn
    |> put_status(:ok)
    |> render("count.json", data: count)
  end
end
