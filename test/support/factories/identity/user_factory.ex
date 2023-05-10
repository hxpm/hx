defmodule Hx.Identity.UserFactory do
  alias Hx.Identity.User

  def new(overrides \\ %{}) do
    password_digest = User.hash_password("p@$$w0rd!")

    %User{}
    |> Map.put(:email, "anthony@hx.pm")
    |> Map.put(:first_name, "Anthony")
    |> Map.put(:last_name, "Smith")
    |> Map.put(:password_digest, password_digest)
    |> Map.merge(overrides)
  end
end
