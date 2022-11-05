defmodule ServerWeb.AuthController do
  use ServerWeb, :controller

  alias Plug.Conn

  alias Server.Helper
  alias Server.User.Services
  alias ServerWeb.JwtToken
  alias Server.AuthTokens.Services, as: Auth

  def signin(conn, %{"token" => params}) do
    case Services.create(params) do
      {:ok, user} ->
        extra_claims = %{user_id: user.id}
        {:ok, token, _claims} = JwtToken.generate_and_sign(extra_claims)
        render(conn, "signin.json", data: token)

      {:error, _error} ->
        conn |> Conn.send_resp(404, Jason.encode!(%{error: "Not valide token"}))
    end
  end

  def logout(conn, _params) do
    user_token =
      Ecto.build_assoc(conn.assigns.current_user, :auth_tokens, %{
        token: Helper.get_token_from_header(conn)
      })

    Auth.create_auth_token(user_token)
    conn |> render("logout.json", data: "Logou")
  end
end
