defmodule Hx.Auth.SessionTest do
  use Hx.DataCase, async: true

  alias Hx.Auth.Session
  alias Hx.Auth.SessionFactory

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

    test "automatically assigns a 32 byte token" do
      user = UserFactory.new() |> Hx.Repo.insert!()

      session = Session.create!(user.id)

      assert byte_size(session.token) == 32
    end
  end

  test "gen_token/0" do
    assert byte_size(Session.gen_token()) == 32
  end

  test "revoke/1" do
    user = UserFactory.new() |> Hx.Repo.insert!()

    session =
      %{user_id: user.id}
      |> SessionFactory.new()
      |> Hx.Repo.insert!()

    assert session = %Session{} = Session.revoke!(session)

    assert session.revoked_at != nil
  end

  test "valid?/1" do
    refute Session.valid?(nil)
    refute Session.valid?(%Session{revoked_at: DateTime.now!("Etc/UTC")})
    assert Session.valid?(%Session{revoked_at: nil})
  end
end
