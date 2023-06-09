defmodule Hx.Identity.CreateUserCommandTest do
  use Hx.DataCase, async: true

  import Hx.Identity.UserAssertions

  alias Hx.Identity.User

  setup do
    args = %{
      email: "anthony@hx.pm",
      first_name: "Anthony",
      last_name: "Smith",
      password: "p@$$w0rd!"
    }

    {:ok, %{args: args}}
  end

  test ":email is required", %{args: args} do
    assert_user_email_is_required(fn changeset ->
      {:error, changeset} =
        args
        |> Map.put(:email, changeset.params["email"])
        |> Hx.Identity.create_user()

      changeset
    end)
  end

  test ":email requires the correct format", %{args: args} do
    assert_user_email_requires_correct_format(fn changeset ->
      {:error, changeset} =
        args
        |> Map.put(:email, changeset.params["email"])
        |> Hx.Identity.create_user()

      changeset
    end)
  end

  test ":email requires uniqueness", %{args: args} do
    assert_user_email_requires_uniqueness(fn changeset ->
      {:error, changeset} =
        args
        |> Map.put(:email, changeset.params["email"])
        |> Hx.Identity.create_user()

      changeset
    end)
  end

  test ":email is downcased", %{args: args} do
    assert_user_email_is_downcased(fn changeset ->
      {:ok, user} =
        args
        |> Map.put(:email, changeset.params["email"])
        |> Hx.Identity.create_user()

      user.email
    end)
  end

  test ":email is trimmed", %{args: args} do
    assert_user_email_is_trimmed(fn changeset ->
      {:ok, user} =
        args
        |> Map.put(:email, changeset.params["email"])
        |> Hx.Identity.create_user()

      user.email
    end)
  end

  test ":first_name is required", %{args: args} do
    assert_user_first_name_is_required(fn changeset ->
      {:error, changeset} =
        args
        |> Map.put(:first_name, changeset.params["first_name"])
        |> Hx.Identity.create_user()

      changeset
    end)
  end

  test ":last_name is required", %{args: args} do
    assert_user_last_name_is_required(fn changeset ->
      {:error, changeset} =
        args
        |> Map.put(:last_name, changeset.params["last_name"])
        |> Hx.Identity.create_user()

      changeset
    end)
  end

  test ":password is required", %{args: args} do
    assert_user_password_is_required(fn changeset ->
      {:error, changeset} =
        args
        |> Map.put(:password, changeset.params["password"])
        |> Hx.Identity.create_user()

      changeset
    end)
  end

  test ":password is at least 8 characters", %{args: args} do
    assert_user_password_requires_min_8_length(fn changeset ->
      {:error, changeset} =
        args
        |> Map.put(:password, changeset.params["password"])
        |> Hx.Identity.create_user()

      changeset
    end)
  end

  test ":password is hashed", %{args: args} do
    assert_user_password_is_hashed(fn changeset ->
      {:ok, user} =
        args
        |> Map.put(:password, changeset.params["password"])
        |> Hx.Identity.create_user()

      user.password_digest
    end)
  end

  test "creates a user", %{args: args} do
    assert Hx.Repo.aggregate(User, :count) == 0

    assert {:ok, %User{}} = Hx.Identity.create_user(args)

    assert Hx.Repo.aggregate(User, :count) == 1
  end
end
