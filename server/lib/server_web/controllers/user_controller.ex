defmodule ServerWeb.UserController do
  use ServerWeb, :controller

  alias Server.User.Services

  def count(conn, _) do
    count = Services.count()

    conn
    |> put_status(:ok)
    |> render("count.json", data: count)
  end

  def get(conn, _params) do
    render(conn, "user.json", data: conn.assigns.current_user)
  end
end
