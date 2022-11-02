defmodule Server.Guess do
  use Ecto.Schema
  import Ecto.Changeset

  alias Server.{Gamer, Participant}

  @params [:fist_team_points, :second_team_points, :gamer_id, :participant_id]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "guess" do
    field :fist_team_points, :integer
    field :second_team_points, :integer
    belongs_to :gamer, Gamer
    belongs_to :participant, Participant
    
    timestamps()
  end

  def changeset(guess, params) do
    guess 
    |> cast(params, @params)
  end

  def changeset(guess, params, gamer = %Gamer{}, participant = %Participant{}) do
    guess 
    |> cast(params, @params)
    |> put_assoc(:gamer, gamer)
    |> put_assoc(:participant, participant)
  end
end
