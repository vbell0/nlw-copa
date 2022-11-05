defmodule ServerWeb.GuessController do
  use ServerWeb, :controller

  alias Server.Guess.Services

  def count(conn, _) do
    data = Services.count()

    conn
    |> put_status(:ok)
    |> render("count.json", data: data)
  end
end
