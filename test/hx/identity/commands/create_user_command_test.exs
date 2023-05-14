defmodule Hx.Idenity.CreateUserCommandTest do
  use Hx.DataCase, async: true

  alias Hx.Identity.User
  alias Hx.Identity.UserFactory

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
    args = Map.put(args, :email, nil)

    assert {:error, changeset} = Hx.Identity.create_user(args)

    assert %Ecto.Changeset{
             errors: [
               email: {_, validation: :required}
             ]
           } = changeset
  end

  test ":email is the correct format", %{args: args} do
    args = Map.put(args, :email, "💩")

    assert {:error, changeset} = Hx.Identity.create_user(args)

    assert %Ecto.Changeset{
             errors: [
               email: {_, validation: :format}
             ]
           } = changeset
  end

  test ":email is unique", %{args: args} do
    user = UserFactory.new() |> Hx.Repo.insert!()

    args = Map.put(args, :email, user.email)

    assert {:error, changeset} = Hx.Identity.create_user(args)

    assert assert %Ecto.Changeset{
                    errors: [
                      email: {_, validation: :unsafe_unique, fields: [:email]}
                    ]
                  } = changeset
  end

  test ":email is downcased", %{args: args} do
    args = Map.put(args, :email, String.upcase(args.email))

    assert {:ok, %User{} = user} = Hx.Identity.create_user(args)

    assert user.email == String.downcase(args.email)
  end

  test ":email is trimmed", %{args: args} do
    args = Map.put(args, :email, " #{args.email} ")

    assert {:ok, %User{} = user} = Hx.Identity.create_user(args)

    assert user.email == String.trim(args.email)
  end

  test ":first_name is required", %{args: args} do
    args = Map.put(args, :first_name, nil)

    assert {:error, changeset} = Hx.Identity.create_user(args)

    assert %Ecto.Changeset{
             errors: [
               first_name: {_, validation: :required}
             ]
           } = changeset
  end

  test ":last_name is required", %{args: args} do
    args = Map.put(args, :last_name, nil)

    assert {:error, changeset} = Hx.Identity.create_user(args)

    assert %Ecto.Changeset{
             errors: [
               last_name: {_, validation: :required}
             ]
           } = changeset
  end

  test ":password is required", %{args: args} do
    args = Map.put(args, :password, nil)

    assert {:error, changeset} = Hx.Identity.create_user(args)

    assert %Ecto.Changeset{
             errors: [
               password: {_, validation: :required}
             ]
           } = changeset
  end

  test ":password is at least 8 characters", %{args: args} do
    args = Map.put(args, :password, "💩")

    assert {:error, changeset} = Hx.Identity.create_user(args)

    assert %Ecto.Changeset{
             errors: [
               password: {_, count: 8, validation: :length, kind: :min, type: :string}
             ]
           } = changeset
  end

  test "creates a user", %{args: args} do
    assert Hx.Repo.aggregate(User, :count) == 0

    assert {:ok, %User{}} = Hx.Identity.create_user(args)

    assert Hx.Repo.aggregate(User, :count) == 1
  end

  test "assigns values to a user when it is created", %{args: args} do
    {:ok, user} = Hx.Identity.create_user(args)

    assert user.email == args.email
    assert user.first_name == args.first_name
    assert user.id != nil
    assert user.inserted_at != nil
    assert user.last_name == args.last_name
    assert user.password == nil
    assert user.password_digest != nil
    assert user.updated_at != nil
  end

  test "hashes the password provided when a user is created", %{args: args} do
    {:ok, user} = Hx.Identity.create_user(args)

    assert User.verify_password(user.password_digest, args.password)
  end
end
