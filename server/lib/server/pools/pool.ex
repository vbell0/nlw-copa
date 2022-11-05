defmodule Server.Pool do
  use Ecto.Schema
  import Ecto.Changeset

  alias Server.User

  @params [:code, :title]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "pool" do
    field :code, :string
    field :title, :string
    belongs_to :owner, User

    timestamps()
  end

  @doc false
  def changeset(pool, params) do
    pool
    |> cast(params, @params)
  end

  @doc false
  def changeset(pool, params, user = %User{}) do
    pool
    |> cast(params, @params)
    |> put_assoc(:owner, user)
    |> validate_length(:title, min: 4)
    |> validate_required(@params)
  end
end
