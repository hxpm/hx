defmodule Hx.ConfigTest do
  use ExUnit.Case, async: false

  @database_pool_size 5
  @database_url "postgres://postgres:postgres@hx-db:5432/hx"

  setup do
    envs = System.get_env()

    System.put_env("HX_DATABASE_POOL_SIZE", to_string(@database_pool_size))
    System.put_env("HX_DATABASE_URL", @database_url)

    on_exit(fn ->
      Enum.each(envs, fn {key, _value} -> System.delete_env(key) end)

      System.put_env(envs)
    end)
  end

  test "to_env/1" do
    assert Hx.Config.to_env(:database_url) == "HX_DATABASE_URL"
  end

  describe "load/0" do
    test "ok" do
      expected =
        Map.new()
        |> Map.put(:database_pool_size, @database_pool_size)
        |> Map.put(:database_url, @database_url)

      assert {:ok, ^expected} = Hx.Config.load()
    end

    test "HX_DATABASE_POOL_SIZE defaults to a value of 10" do
      env = "HX_DATABASE_POOL_SIZE"

      System.delete_env(env)

      assert {:ok, %{database_pool_size: 10}} = Hx.Config.load()
    end

    test "HX_DATABASE_POOL_SIZE must be a positive integer" do
      env = "HX_DATABASE_POOL_SIZE"

      message = "#{env} must be a positive integer."

      Enum.each(["-1", "0", "1.0", "💩"], fn value ->
        System.put_env(env, value)

        assert {:error, ^message} = Hx.Config.load()
      end)
    end

    test "HX_DATABASE_URL is required" do
      env = "HX_DATABASE_URL"

      message = "#{env} is required."

      System.delete_env(env)

      assert {:error, ^message} = Hx.Config.load()

      System.put_env(env, "")

      assert {:error, ^message} = Hx.Config.load()
    end
  end
end
