defmodule Hx.Auth.SessionTest do
  use Hx.DataCase, async: true

  alias Hx.Auth.Session

  test "gen_token/0" do
    byte_size =
      Session.gen_token()
      |> Base.decode16!()
      |> byte_size()

    assert byte_size == 32
  end

  test "valid?/1" do
    refute Session.valid?(nil)
    refute Session.valid?(%Session{revoked_at: DateTime.now!("Etc/UTC")})
    assert Session.valid?(%Session{revoked_at: nil})
  end
end
