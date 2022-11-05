defmodule Server.Guess do
  use Ecto.Schema
  import Ecto.Changeset

  alias Server.{Game, Participant}

  @params [:fist_team_points, :second_team_points, :game_id, :participant_id]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "guess" do
    field :fist_team_points, :integer
    field :second_team_points, :integer
    belongs_to :game, Game
    belongs_to :participant, Participant

    timestamps()
  end

  @doc false
  def changeset(guess, params) do
    guess
    |> cast(params, @params)
  end
end
