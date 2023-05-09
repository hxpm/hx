defmodule Hx.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false

      add :first_name, :string, null: false

      add :last_name, :string, null: false

      add :password_digest, :string

      timestamps()
    end

    create index(:users, :email, unique: true)
  end
end
