defmodule Hx.Repo.Migrations.CreateSessionsTable do
  use Ecto.Migration

  def change do
    create table(:sessions) do
      add :revoked_at, :utc_datetime

      add :token, :string, null: false

      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:sessions, :token, unique: true)
  end
end
