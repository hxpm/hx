defmodule Hx.Identity.UserAssertions do
  import ExUnit.Assertions, only: [assert: 1]

  alias Hx.Identity.User
  alias Hx.Identity.UserFactory

  def assert_user_email_is_downcased(fun) do
    email =
      UserFactory.new()
      |> Map.get(:email)
      |> String.upcase()

    email_or_changeset =
      %User{}
      |> Ecto.Changeset.cast(%{email: email}, [:email])
      |> fun.()

    case email_or_changeset do
      %Ecto.Changeset{} ->
        assert String.downcase(email) == Ecto.Changeset.get_change(email_or_changeset, :email)

      _otherwise ->
        assert String.downcase(email) == email_or_changeset
    end
  end

  def assert_user_email_is_required(fun) do
    changeset =
      %User{}
      |> Ecto.Changeset.cast(%{email: ""}, [:email])
      |> fun.()

    assert %Ecto.Changeset{
             errors: [
               email: {_, validation: :required}
             ]
           } = changeset
  end

  def assert_user_email_is_trimmed(fun) do
    user = UserFactory.new()

    email = " #{user.email} "

    email_or_changeset =
      %User{}
      |> Ecto.Changeset.cast(%{email: email}, [:email])
      |> fun.()

    case email_or_changeset do
      %Ecto.Changeset{} ->
        assert String.trim(email) == Ecto.Changeset.get_change(email_or_changeset, :email)

      _otherwise ->
        assert String.trim(email) == email_or_changeset
    end
  end

  def assert_user_email_is_valid(fun) do
    user = UserFactory.new()

    changeset =
      %User{}
      |> Ecto.Changeset.cast(%{email: user.email}, [:email])
      |> fun.()

    assert %Ecto.Changeset{
             valid?: true
           } = changeset
  end

  def assert_user_email_requires_correct_format(fun) do
    changeset =
      %User{}
      |> Ecto.Changeset.cast(%{email: "💩"}, [:email])
      |> fun.()

    assert %Ecto.Changeset{
             errors: [
               email: {_, validation: :format}
             ]
           } = changeset
  end

  def assert_user_email_requires_uniqueness(fun) do
    user = UserFactory.new() |> Hx.Repo.insert!()

    changeset =
      %User{}
      |> Ecto.Changeset.cast(%{email: user.email}, [:email])
      |> fun.()

    assert %Ecto.Changeset{
             errors: [
               email: {_, validation: :unsafe_unique, fields: [:email]}
             ]
           } = changeset
  end

  def assert_user_first_name_is_required(fun) do
    changeset =
      %User{}
      |> Ecto.Changeset.cast(%{first_name: ""}, [:first_name])
      |> fun.()

    assert %Ecto.Changeset{
             errors: [
               first_name: {_, validation: :required}
             ]
           } = changeset
  end

  def assert_user_first_name_is_valid(fun) do
    user = UserFactory.new()

    changeset =
      %User{}
      |> Ecto.Changeset.cast(%{first_name: user.first_name}, [:first_name])
      |> fun.()

    assert %Ecto.Changeset{
             valid?: true
           } = changeset
  end

  def assert_user_last_name_is_required(fun) do
    changeset =
      %User{}
      |> Ecto.Changeset.cast(%{last_name: ""}, [:last_name])
      |> fun.()

    assert %Ecto.Changeset{
             errors: [
               last_name: {_, validation: :required}
             ]
           } = changeset
  end

  def assert_user_last_name_is_valid(fun) do
    changeset =
      %User{}
      |> Ecto.Changeset.cast(%{last_name: "Smith"}, [:last_name])
      |> fun.()

    assert %Ecto.Changeset{
             valid?: true
           } = changeset
  end

  def assert_user_password_is_hashed(fun) do
    password = "p@$$w0rd!"

    password_digest_or_changeset =
      %User{}
      |> Ecto.Changeset.cast(%{password: password}, [:password])
      |> fun.()

    case password_digest_or_changeset do
      %Ecto.Changeset{} ->
        assert password_digest_or_changeset
               |> Ecto.Changeset.get_change(:password_digest)
               |> User.verify_password(password)

      _otherwise ->
        assert User.verify_password(password_digest_or_changeset, password)
    end
  end

  def assert_user_password_is_required(fun) do
    changeset =
      %User{}
      |> Ecto.Changeset.cast(%{password: ""}, [:password])
      |> fun.()

    assert %Ecto.Changeset{
             errors: [
               password: {_, validation: :required}
             ]
           } = changeset
  end

  def assert_user_password_is_valid(fun) do
    changeset =
      %User{}
      |> Ecto.Changeset.cast(%{password: "p@$$w0rd!"}, [:password])
      |> fun.()

    assert %Ecto.Changeset{
             valid?: true
           } = changeset
  end

  def assert_user_password_requires_min_8_length(fun) do
    changeset =
      %User{}
      |> Ecto.Changeset.cast(%{password: "💩"}, [:password])
      |> fun.()

    assert %Ecto.Changeset{
             errors: [
               password: {_, count: 8, validation: :length, kind: :min, type: :string}
             ]
           } = changeset
  end
end
