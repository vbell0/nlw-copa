defmodule Server.AuthTokens.Services do
  @moduledoc """
  The AuthTokens context.
  """

  import Ecto.Query, warn: false
  alias Server.Repo

  alias Server.AuthTokens

  def list_auth_token do
    Repo.all(AuthToken)
  end

  def get_auth_token!(id), do: Repo.get!(AuthTokens, id)

  def get_auth_token_form_token(token) do
    Repo.get_by(AuthTokens, token: "#{token}")
  end

  def create_auth_token(params = %AuthTokens{}) do
    params
    |> Repo.insert!()
  end

  def update_auth_token(%AuthTokens{} = auth_token, attrs) do
    auth_token
    |> AuthTokens.changeset(attrs)
    |> Repo.update()
  end

  def delete_auth_token(%AuthTokens{} = auth_token) do
    Repo.delete(auth_token)
  end

  def change_auth_token(%AuthTokens{} = auth_token, attrs \\ %{}) do
    AuthTokens.changeset(auth_token, attrs)
  end
end
