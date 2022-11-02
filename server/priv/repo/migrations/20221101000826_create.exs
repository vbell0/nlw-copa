defmodule Server.Repo.Migrations.Create do
  use Ecto.Migration

  def change do
    create table(:user, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :email, :string
      add :avatar_url, :string

      timestamps()
    end

    create table(:pool, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :code, :string
      add :title, :string
      add :owner_id, references(:user, column: :id, type: :uuid)

      timestamps()
    end

    create table(:participant, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:user, type: :uuid)
      add :pool_id, references(:pool, type: :uuid)
    end

    create table(:gamer, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :date, :date
      add :fist_team_country_code, :string
      add :secound_team_country_code, :string
    end

    create table(:guess, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :fist_team_points, :integer
      add :second_team_points, :integer
      add :gamer_id, references(:gamer, type: :uuid)
      add :participant_id, references(:participant, type: :uuid)
      
      timestamps()
    end

    create unique_index :pool, [:code]
    create unique_index :user, [:email]
    create unique_index :participant, [:user_id, :pool_id]
  end
end
