defmodule Hx.Auth.Session do
  @moduledoc """
  Statefully identifies wether a user is authenticated or not.
  """

  use Hx.Schema

  @type t ::
          %__MODULE__{
            __meta__: Ecto.Schema.Metadata.t(),
            id: integer,
            inserted_at: DateTime.t(),
            revoked_at: DateTime.t(),
            token: String.t(),
            updated_at: DateTime.t(),
            user: Hx.Identity.User.t(),
            user_id: integer
          }

  schema "sessions" do
    field :revoked_at, :utc_datetime

    field :token, :string

    belongs_to :user, Hx.Identity.User

    timestamps()
  end

  @doc """
  Creates a session for the given user.
  """
  @spec create!(integer) :: t | no_return
  def create!(user_id) do
    %__MODULE__{}
    |> Ecto.Changeset.cast(%{user_id: user_id}, [:user_id])
    |> Ecto.Changeset.put_change(:token, gen_token())
    |> Ecto.Changeset.foreign_key_constraint(:user_id)
    |> Ecto.Changeset.unique_constraint(:token)
    |> Hx.Repo.insert!()
  end

  @doc """
  Generates a securely random 32 byte session token.
  """
  @spec gen_token() :: String.t()
  def gen_token do
    Hx.Crypto.strong_rand_string(32)
  end

  @doc """
  Revokes the session.

  When a session is revoked it is no longer considered valid.
  """
  @spec revoke!(t) :: t | no_return
  def revoke!(session) do
    session
    |> Ecto.Changeset.cast(%{revoked_at: DateTime.now!("Etc/UTC")}, [:revoked_at])
    |> Hx.Repo.update!()
  end

  @doc """
  Determines if the user associated with the session is authenticated.

  A session is only valid if `revoked_at` is `nil`. If `revoked_at` is in the
  future the session is still considered invalid.
  """
  @spec valid?(t) :: boolean()
  def valid?(session) do
    cond do
      is_nil(session) ->
        false

      is_nil(session.revoked_at) ->
        true

      true ->
        false
    end
  end
end
