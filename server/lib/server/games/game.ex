defmodule Server.Game do
  use Ecto.Schema
  import Ecto.Changeset

  @params [:date, :fist_team_country_code, :secound_team_country_code]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "game" do
    field :date, :date
    field :fist_team_country_code, :string
    field :secound_team_country_code, :string
  end

  @doc false
  def changeset(game, params) do
    game
    |> cast(params, @params)
  end
end
