defmodule Hx.UserTest do
  use Hx.DataCase, async: true

  alias Hx.User

  test "hash_password/1" do
    password = "p@$$w0rd!"

    password_digest = User.hash_password(password)

    assert Argon2.verify_pass(password, password_digest)
  end

  test "verify_password/2" do
    password = "p@$$w0rd!"

    password_digest = Argon2.hash_pwd_salt(password)

    assert User.verify_password(password_digest, password)
  end
end
