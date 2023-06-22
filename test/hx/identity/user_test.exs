defmodule Hx.Identity.UserTest do
  use Hx.DataCase, async: true

  import Hx.Identity.UserAssertions

  alias Hx.Identity.User

  describe "change_email/1" do
    test ":email is required" do
      assert_user_email_is_required(&User.change_email/1)
    end

    test ":email requires the correct format" do
      assert_user_email_requires_correct_format(&User.change_email/1)
    end

    test ":email requires uniqueness" do
      assert_user_email_requires_uniqueness(&User.change_email/1)
    end

    test ":email is downcased" do
      assert_user_email_is_downcased(&User.change_email/1)
    end

    test ":email is trimmed" do
      assert_user_email_is_trimmed(&User.change_email/1)
    end

    test ":email can be valid" do
      assert_user_email_is_valid(&User.change_email/1)
    end
  end

  describe "change_password/1" do
    test ":password is required" do
      assert_user_password_is_required(&User.change_password/1)
    end

    test ":password is at least 8 characters" do
      assert_user_password_requires_min_8_length(&User.change_password/1)
    end

    test ":password is hashed" do
      assert_user_password_is_hashed(&User.change_password/1)
    end

    test ":password can be valid" do
      assert_user_password_is_valid(&User.change_password/1)
    end
  end

  describe "changeset/3 for :insert" do
    setup do
      args = %{
        email: "anthony@hx.pm",
        first_name: "Anthony",
        last_name: "Smith",
        password: "p@$$w0rd!"
      }

      {:ok, %{args: args}}
    end

    test ":email is required", %{args: args} do
      assert_user_email_is_required(fn changeset ->
        User.changeset(%User{}, %{args | email: changeset.params["email"]}, for: :insert)
      end)
    end

    test ":email requires the correct format", %{args: args} do
      assert_user_email_requires_correct_format(fn changeset ->
        User.changeset(%User{}, %{args | email: changeset.params["email"]}, for: :insert)
      end)
    end

    test ":email requires uniqueness", %{args: args} do
      assert_user_email_requires_uniqueness(fn changeset ->
        User.changeset(%User{}, %{args | email: changeset.params["email"]}, for: :insert)
      end)
    end

    test ":email is downcased", %{args: args} do
      assert_user_email_is_downcased(fn changeset ->
        User.changeset(%User{}, %{args | email: changeset.params["email"]}, for: :insert)
      end)
    end

    test ":email is trimmed", %{args: args} do
      assert_user_email_is_trimmed(fn changeset ->
        User.changeset(%User{}, %{args | email: changeset.params["email"]}, for: :insert)
      end)
    end

    test ":email can be valid", %{args: args} do
      assert_user_email_is_valid(fn changeset ->
        User.changeset(%User{}, %{args | email: changeset.params["email"]}, for: :insert)
      end)
    end

    test ":first_name is required", %{args: args} do
      assert_user_first_name_is_required(fn changeset ->
        User.changeset(
          %User{},
          %{args | first_name: changeset.params["first_name"]},
          for: :insert
        )
      end)
    end

    test ":first_name can be valid", %{args: args} do
      assert_user_first_name_is_valid(fn changeset ->
        User.changeset(
          %User{},
          %{args | first_name: changeset.params["first_name"]},
          for: :insert
        )
      end)
    end

    test ":last_name is required", %{args: args} do
      assert_user_last_name_is_valid(fn changeset ->
        User.changeset(%User{}, %{args | last_name: changeset.params["last_name"]}, for: :insert)
      end)
    end

    test ":last_name can be valid", %{args: args} do
      assert_user_last_name_is_valid(fn changeset ->
        User.changeset(%User{}, %{args | last_name: changeset.params["last_name"]}, for: :insert)
      end)
    end

    test ":password is required", %{args: args} do
      assert_user_password_is_required(fn changeset ->
        User.changeset(%User{}, %{args | password: changeset.params["password"]}, for: :insert)
      end)
    end

    test ":password is at least 8 characters", %{args: args} do
      assert_user_password_requires_min_8_length(fn changeset ->
        User.changeset(%User{}, %{args | password: changeset.params["password"]}, for: :insert)
      end)
    end

    test ":password is hashed", %{args: args} do
      assert_user_password_is_hashed(fn changeset ->
        User.changeset(%User{}, %{args | password: changeset.params["password"]}, for: :insert)
      end)
    end

    test ":password can be valid", %{args: args} do
      assert_user_password_is_valid(fn changeset ->
        User.changeset(%User{}, %{args | password: changeset.params["password"]}, for: :insert)
      end)
    end
  end

  test "hash_password/1" do
    password = "p@$$w0rd!"

    password_digest = User.hash_password(password)

    assert Argon2.verify_pass(password, password_digest)
  end

  describe "validate_email/1" do
    test ":email is required" do
      assert_user_email_is_required(&User.validate_email/1)
    end

    test ":email requires the correct format" do
      assert_user_email_requires_correct_format(&User.validate_email/1)
    end

    test ":email requires uniqueness" do
      assert_user_email_requires_uniqueness(&User.validate_email/1)
    end

    test ":email can be valid" do
      assert_user_email_is_valid(&User.validate_email/1)
    end
  end

  describe "validate_first_name/1" do
    test ":first_name is required" do
      assert_user_first_name_is_required(&User.validate_first_name/1)
    end

    test ":first_name can be valid" do
      assert_user_first_name_is_valid(&User.validate_first_name/1)
    end
  end

  describe "validate_last_name/1" do
    test ":last_name is required" do
      assert_user_last_name_is_required(&User.validate_last_name/1)
    end

    test ":last_name can be valid" do
      assert_user_last_name_is_valid(&User.validate_last_name/1)
    end
  end

  describe "validate_password/1" do
    test ":password is required" do
      assert_user_password_is_required(&User.validate_password/1)
    end

    test ":password is at least 8 characters" do
      assert_user_password_requires_min_8_length(&User.validate_password/1)
    end

    test ":password can be valid" do
      assert_user_password_is_valid(&User.validate_password/1)
    end
  end

  test "verify_password/2" do
    password = "p@$$w0rd!"

    password_digest = Argon2.hash_pwd_salt(password)

    assert User.verify_password(password_digest, password)
  end
end
