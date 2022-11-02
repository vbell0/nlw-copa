defmodule Server.Participant do
  use Ecto.Schema
  import Ecto.Changeset

  alias Server.{User, Pool}

  @params [:user_id, :pool_id]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "participant" do
    belongs_to :user, User
    belongs_to :pool, Pool
  end

  def changeset(participant, params) do
    participant
    |> cast(params, @params)
  end

  def changeset(participant, params, user = %User{}, pool = %Pool{}) do
    participant
    |> cast(params, @params)
    |> unique_constraint([:user, :pool])
    |> put_assoc(:user, user)
    |> put_assoc(:pool, pool)
  end
end
