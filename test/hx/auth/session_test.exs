defmodule Hx.Auth.SessionTest do
  use Hx.DataCase, async: true

  alias Hx.Auth.Session

  alias Hx.Identity.UserFactory

  describe "create/1" do
    test "foreign key is enforced" do
      assert_raise Ecto.InvalidChangesetError, ~r/constraint: :foreign/, fn ->
        Session.create!(0)
      end
    end

    test "creates a session" do
      user = UserFactory.new() |> Hx.Repo.insert!()

      assert Hx.Repo.aggregate(Session, :count) == 0

      assert %Session{} = Session.create!(user.id)

      assert Hx.Repo.aggregate(Session, :count) == 1
    end
  end

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
