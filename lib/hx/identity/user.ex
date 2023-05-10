defmodule Hx.Identity.User do
  @moduledoc """
  Individual or entity who interacts with the Hx application.
  """

  use Hx.Schema

  @type t ::
          %__MODULE__{
            __meta__: Ecto.Schema.Metadata.t(),
            email: String.t(),
            first_name: String.t(),
            id: integer,
            inserted_at: DateTime.t(),
            last_name: String.t(),
            password: String.t(),
            password_digest: String.t(),
            updated_at: DateTime.t()
          }

  schema "users" do
    field :email, :string

    field :first_name, :string

    field :last_name, :string

    field :password, :string, redact: true, virtual: true

    field :password_digest, :string, redact: true

    timestamps()
  end

  @doc """
  Updates an `Ecto.Changeset` with a hashed password.

  If successful the `:password` field will be removed and the `:password_digest`
  field will be populated with the hashed password. Performs the same
  validations as `validate_password/1` before making any changes.
  """
  @spec change_password(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  def change_password(changeset) do
    changeset = validate_password(changeset)

    if changeset.valid? do
      password = Ecto.Changeset.get_change(changeset, :password)

      changeset
      |> Ecto.Changeset.put_change(:password, nil)
      |> Ecto.Changeset.put_change(:password_digest, hash_password(password))
    else
      changeset
    end
  end

  @doc """
  Hashes a password with a randomly generated salt.
  """
  @spec hash_password(String.t()) :: String.t()
  def hash_password(password) do
    Argon2.hash_pwd_salt(password)
  end

  @doc """
  Validates that `:email` is required, has the correct format, and is unique.
  """
  @spec validate_email(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  def validate_email(changeset) do
    changeset
    |> Ecto.Changeset.validate_required(:email)
    |> Ecto.Changeset.validate_format(:email, ~r/\S+@\S+/)
    |> Ecto.Changeset.unsafe_validate_unique(:email, Hx.Repo)
    |> Ecto.Changeset.unique_constraint(:email)
  end

  @doc """
  Validates that `:first_name` is required.
  """
  @spec validate_first_name(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  def validate_first_name(changeset) do
    Ecto.Changeset.validate_required(changeset, :first_name)
  end

  @doc """
  Validates that `:last_name` is required.
  """
  @spec validate_last_name(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  def validate_last_name(changeset) do
    Ecto.Changeset.validate_required(changeset, :last_name)
  end

  @doc """
  Validates that `:password` is required and has a minimum length of 8.
  """
  @spec validate_password(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  def validate_password(changeset) do
    changeset
    |> Ecto.Changeset.validate_required(:password)
    |> Ecto.Changeset.validate_length(:password, min: 8)
  end

  @doc """
  Verifies a password against a password hash.
  """
  @spec verify_password(String.t(), String.t()) :: boolean
  def verify_password(password_digest, password) do
    Argon2.verify_pass(password, password_digest)
  end
end
