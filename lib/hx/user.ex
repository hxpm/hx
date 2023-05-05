defmodule Hx.User do
  @doc """
  Hashes a password with a randomly generated salt.
  """
  @spec hash_password(String.t()) :: String.t()
  def hash_password(password) do
    Argon2.hash_pwd_salt(password)
  end

  @doc """
  Verifies a password against a hash.
  """
  @spec verify_password(String.t(), String.t()) :: boolean
  def verify_password(password_digest, password) do
    Argon2.verify_pass(password, password_digest)
  end
end
