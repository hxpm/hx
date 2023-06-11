defmodule Hx.Repo.Migrations.CreateSystemSettingsTable do
  use Ecto.Migration

  def change do
    create table(:system_settings, primary_key: false) do
      add :key, :string, primary_key: true

      add :value, :string

      timestamps()
    end

    create index(:system_settings, :key, unique: true)
  end
end
