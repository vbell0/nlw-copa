defmodule Server.Repo.Migrations.CreateAuthToken do
  use Ecto.Migration

  def change do
    create table(:auth_token, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :token, :text, null: false
      add :user_id, references(:user, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:auth_token, [:user_id, :token])
  end
end
