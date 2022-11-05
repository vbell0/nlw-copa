defmodule Server.Repo.Migrations.AddGoogleId do
  use Ecto.Migration

  def change do
    alter table(:user) do
      add :google_id, :string
    end

    create unique_index(:user, [:google_id])
  end
end
