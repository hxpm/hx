defmodule Hx.UserTest do
  use Hx.DataCase, async: true

  alias Hx.User
  alias Hx.UserFactory

  test "hash_password/1" do
    password = "p@$$w0rd!"

    password_digest = User.hash_password(password)

    assert Argon2.verify_pass(password, password_digest)
  end

  describe "validate_email/1" do
    test "is required" do
      changeset = Ecto.Changeset.cast(%User{}, %{email: ""}, [:email])

      assert %Ecto.Changeset{
               errors: [
                 email: {_, validation: :required}
               ]
             } = User.validate_email(changeset)
    end

    test "has correct format" do
      changeset = Ecto.Changeset.cast(%User{}, %{email: "💩"}, [:email])

      assert %Ecto.Changeset{
               errors: [
                 email: {_, validation: :format}
               ]
             } = User.validate_email(changeset)
    end

    test "is unique" do
      user = UserFactory.new() |> Hx.Repo.insert!()

      changeset = Ecto.Changeset.cast(%User{}, %{email: user.email}, [:email])

      assert %Ecto.Changeset{
               errors: [
                 email: {_, validation: :unsafe_unique, fields: [:email]}
               ]
             } = User.validate_email(changeset)
    end

    test "can be valid" do
      changeset = Ecto.Changeset.cast(%User{}, %{email: "anthony@hx.pm"}, [:email])

      assert %Ecto.Changeset{
               valid?: true
             } = User.validate_email(changeset)
    end
  end

  describe "validate_first_name/1" do
    test "is required" do
      changeset = Ecto.Changeset.cast(%User{}, %{first_name: ""}, [:first_name])

      assert %Ecto.Changeset{
               errors: [
                 first_name: {_, validation: :required}
               ]
             } = User.validate_first_name(changeset)
    end

    test "can be valid" do
      changeset = Ecto.Changeset.cast(%User{}, %{first_name: "Anthony"}, [:first_name])

      assert %Ecto.Changeset{
               valid?: true
             } = User.validate_first_name(changeset)
    end
  end

  describe "validate_last_name/1" do
    test "is required" do
      changeset = Ecto.Changeset.cast(%User{}, %{last_name: ""}, [:last_name])

      assert %Ecto.Changeset{
               errors: [
                 last_name: {_, validation: :required}
               ]
             } = User.validate_last_name(changeset)
    end

    test "can be valid" do
      changeset = Ecto.Changeset.cast(%User{}, %{last_name: "Anthony"}, [:last_name])

      assert %Ecto.Changeset{
               valid?: true
             } = User.validate_last_name(changeset)
    end
  end

  describe "validate_password/1" do
    test "is required" do
      changeset = Ecto.Changeset.cast(%User{}, %{password: ""}, [:password])

      assert %Ecto.Changeset{
               errors: [
                 password: {_, validation: :required}
               ]
             } = User.validate_password(changeset)
    end

    test "is at least 8 characters" do
      changeset = Ecto.Changeset.cast(%User{}, %{password: "💩"}, [:password])

      assert %Ecto.Changeset{
               errors: [
                 password: {_, count: 8, validation: :length, kind: :min, type: :string}
               ]
             } = User.validate_password(changeset)
    end

    test "can be valid" do
      changeset = Ecto.Changeset.cast(%User{}, %{password: "p@$$w0rd!"}, [:password])

      assert %Ecto.Changeset{
               valid?: true
             } = User.validate_password(changeset)
    end
  end

  test "verify_password/2" do
    password = "p@$$w0rd!"

    password_digest = Argon2.hash_pwd_salt(password)

    assert User.verify_password(password_digest, password)
  end
end
