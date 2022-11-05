defmodule ServerWeb.JwtPlug do
  import Plug.Conn

  alias Server.{User, Helper}
  alias Server.User.Services

  def init(opts), do: opts

  def call(conn, _) do
    token = Helper.get_token_from_header(conn)

    with {:ok, %{"user_id" => user_id}} <- ServerWeb.JwtToken.verify_and_validate(token),
         %User{} = user <- Services.get_user(user_id) do
      case Server.AuthTokens.Services.get_auth_token_form_token(token) do
        nil ->
          conn |> assign(:current_user, user)

        _ ->
          Helper.not_autorization(conn)
      end
    else
      {:error, _} -> conn |> Helper.not_autorization()
      _ -> conn |> Helper.not_autorization()
    end
  end
end
