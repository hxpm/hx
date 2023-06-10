defmodule Hx.Auth do
  @doc """
  Creates a session for the given user.

  ## Arguments
  * `user_id` - existing user's id
  """
  defdelegate create_session!(user_id),
    as: :create!,
    to: Hx.Auth.Session
end
