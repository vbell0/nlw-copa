defmodule Server.Pools.Pool do
  use Ecto.Schema
  import Ecto.Changeset

  @params_required [:code, :title]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "pools" do
    field :code, :string
    field :title, :string

    timestamps()
  end

  def changeset(pool, attrs) do
    pool
    |> cast(attrs, @params_required)
    |> validate_required(@params_required)
  end
end
