defmodule Server.Repo.Migrations.CreatePools do
  use Ecto.Migration

  def change do
    create table(:pools, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :code, :string
      add :title, :string

      timestamps()
    end

    create unique_index :pools, [:code]
  end
end
