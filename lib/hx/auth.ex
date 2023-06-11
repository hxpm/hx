defmodule Hx.Auth do
  @doc """
  Creates a session for the given user.

  ## Arguments
  * `user_id` (integer) - existing user's id
  """
  defdelegate create_session!(user_id),
    as: :create!,
    to: Hx.Auth.Session

  @doc """
  Revokes a session.

  ## Arguments
  * `session` (`Hx.Auth.Session`) - existing session to revoke
  """
  defdelegate revoke_session!(session),
    as: :revoke!,
    to: Hx.Auth.Session
end
