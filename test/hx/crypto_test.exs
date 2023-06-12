defmodule Hx.CryptoTest do
  use ExUnit.Case, async: true

  alias Hx.Crypto

  test "strong_rand_string/1" do
    assert 16
           |> Crypto.strong_rand_string()
           |> byte_size() == 16

    assert 32
           |> Crypto.strong_rand_string()
           |> byte_size() == 32

    assert 64
           |> Crypto.strong_rand_string()
           |> byte_size() == 64
  end
end
