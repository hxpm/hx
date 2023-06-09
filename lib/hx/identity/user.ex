defmodule Hx.Identity.User do
  @moduledoc """
  Individual or entity who interacts with the Hx application.
  """

  use Hx.Schema

  @type changeset_action_t ::
          :insert

  @type t ::
          %__MODULE__{
            __meta__: Ecto.Schema.Metadata.t(),
            email: nil | String.t(),
            first_name: nil | String.t(),
            id: nil | integer,
            inserted_at: nil | DateTime.t(),
            last_name: nil | String.t(),
            password: nil | String.t(),
            password_digest: nil | String.t(),
            updated_at: nil | DateTime.t()
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
  Updates a change to `:email` so that it is in a valid and normalized
  state before persisting.

  Prefer this function over `validate_email/1` when inserting a user or
  updating the `:email` field for an existing user.

  Performs the same validations as `validate_email/1`.
  """
  @spec change_email(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  def change_email(changeset) do
    changeset
    |> Ecto.Changeset.validate_required(:email)
    |> Ecto.Changeset.update_change(:email, &String.downcase/1)
    |> Ecto.Changeset.update_change(:email, &String.trim/1)
    |> validate_email()
  end

  @doc """
  Updates an `Ecto.Changeset` so that changes to `:password` are in a valid and
  secure state before persisting.

  Prefer this function over `validate_password/1` when inserting a user.

  Performs the same validations as `validate_password/1`.
  """
  @spec change_password(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  def change_password(changeset) do
    changeset = validate_password(changeset)

    if changeset.valid? do
      password = Ecto.Changeset.get_change(changeset, :password)

      changeset
      |> Ecto.Changeset.delete_change(:password)
      |> Ecto.Changeset.put_change(:password_digest, hash_password(password))
    else
      changeset
    end
  end

  @doc """
  Builds a changeset for a specific action.
  """
  @spec changeset(t, map, for: changeset_action_t) :: Ecto.Changeset.t()
  def changeset(user, props, for: :insert) do
    user
    |> Ecto.Changeset.cast(props, [:email, :first_name, :last_name, :password])
    |> change_email()
    |> validate_first_name()
    |> validate_last_name()
    |> change_password()
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
