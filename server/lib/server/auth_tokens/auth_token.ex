defmodule Server.AuthTokens do
  use Ecto.Schema
  import Ecto.Changeset

  alias Server.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Jason.Encoder, except: [:__meta__]}
  schema "auth_token" do
    field :token, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(auth_token, attrs) do
    auth_token
    |> cast(attrs, [:token, :user_id])
    |> unique_constraint(:token)
    |> validate_required([:token])
  end
end
