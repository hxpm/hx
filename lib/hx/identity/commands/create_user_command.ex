defmodule Hx.Identity.CreateUserCommand do
  @moduledoc false

  alias Hx.Identity.User

  alias Hx.Repo

  @spec call(%{
          email: String.t(),
          first_name: String.t(),
          last_name: String.t(),
          password: String.t()
        }) ::
          {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  def call(args) do
    %User{}
    |> Ecto.Changeset.cast(args, [:email, :first_name, :last_name, :password])
    |> User.change_email()
    |> User.validate_first_name()
    |> User.validate_last_name()
    |> User.change_password()
    |> Repo.insert()
  end
end
