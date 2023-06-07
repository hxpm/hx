defmodule Hx.ChangesetTest do
  use ExUnit.Case, async: true

  test "remove_errors/2" do
    changeset =
      {%{}, %{email: :string}}
      |> Ecto.Changeset.cast(%{}, [:email])
      |> Ecto.Changeset.validate_required(:email)

    assert [email: {_, validation: :required}] = changeset.errors

    changeset = Hx.Changeset.remove_errors(changeset, :email)

    assert [] == changeset.errors
  end
end
