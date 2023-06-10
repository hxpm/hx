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

  schema "session" do
    field :revoked_at, :utc_datetime

    field :token, :string

    belongs_to :user, Hx.Identity.User

    timestamps()
  end
end
