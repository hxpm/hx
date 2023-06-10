defmodule Hx.Auth.SessionTest do
  use Hx.DataCase, async: true

  alias Hx.Auth.Session

  test "valid?/1" do
    refute Session.valid?(nil)
    refute Session.valid?(%Session{revoked_at: DateTime.now!("Etc/UTC")})
    assert Session.valid?(%Session{revoked_at: nil})
  end
end
