defmodule Server.User do
  use Ecto.Schema
  import Ecto.Changeset

  @params_required [:name, :email]
  @params [:name, :email, :avatar_url]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "user" do
    field :name, :string 
    field :email, :string
    field :avatar_url, :string

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, @params)
    |> validate_required(@params_required)
  end
end
