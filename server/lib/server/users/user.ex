defmodule Server.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Server.AuthTokens

  @params_required [:name, :email]
  @params [:name, :email, :avatar_url, :google_id]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Jason.Encoder, except: [:__meta__]}
  schema "user" do
    field :name, :string
    field :email, :string
    field :google_id, :string
    field :avatar_url, :string

    has_many :auth_tokens, AuthTokens

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @params)
    |> unique_constraint(:google_id)
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_required(@params_required)
  end
end
