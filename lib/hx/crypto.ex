defmodule Hx.Crypto do
  @moduledoc """
  Functions for performing cryptographic operations.
  """

  @doc """
  Generates a secure random string for the given length.
  """
  @spec strong_rand_string(pos_integer) :: String.t()
  def strong_rand_string(length) do
    length
    |> :crypto.strong_rand_bytes()
    |> Base.encode64(padding: false)
    |> binary_part(0, length)
  end
end
