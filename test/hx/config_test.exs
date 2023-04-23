defmodule Hx.ConfigTest do
  use ExUnit.Case, async: false

  test "to_env/1" do
    assert Hx.Config.to_env(:database_url) == "HX_DATABASE_URL"
  end

  describe "load/0" do
    setup do
      System.put_env("HX_DATABASE_URL", "postgres://postgres:postgres@hx-db:5432/hx")
    end

    test "ok" do
      assert {:ok, _} = Hx.Config.load()
    end

    test "HX_DATABASE_URL is required" do
      env = "HX_DATABASE_URL"

      message = "HX_DATABASE_URL is required."

      System.delete_env(env)

      assert {:error, ^message} = Hx.Config.load()

      System.put_env(env, "")

      assert {:error, ^message} = Hx.Config.load()
    end
  end
end
