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
    |> User.changeset(args, for: :insert)
    |> Repo.insert()
  end
end
