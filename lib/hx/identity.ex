defmodule Hx.Identity do
  @doc """
  Creates a user.

  ## Arguments
  * `:email` - user's email address
  * `:first_name` - user's first name
  * `:last_name` - user's last name
  * `:password` - user's password
  """
  defdelegate create_user(args),
    as: :call,
    to: Hx.Identity.CreateUserCommand
end
