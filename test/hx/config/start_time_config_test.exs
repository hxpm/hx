defmodule Hx.StartTimeConfigTest do
  use ExUnit.Case, async: false

  alias Hx.StartTimeConfig

  @database_pool_size 5
  @database_url "postgres://postgres:postgres@hx-db:5432/hx"
  @port 4001
  @secret_key "fake-secret-key"
  @signing_salt "fake-signing-salt"

  setup do
    envs = System.get_env()

    System.put_env("HX_DATABASE_POOL_SIZE", to_string(@database_pool_size))
    System.put_env("HX_DATABASE_URL", @database_url)
    System.put_env("HX_PORT", to_string(@port))
    System.put_env("HX_SECRET_KEY", @secret_key)
    System.put_env("HX_SIGNING_SALT", @signing_salt)

    on_exit(fn ->
      Enum.each(envs, fn {key, _value} -> System.delete_env(key) end)

      System.put_env(envs)
    end)
  end

  test "get/2", tags do
    proc_name = Module.concat(StartTimeConfig, to_string(tags[:line]))

    start_supervised!({StartTimeConfig, name: proc_name})

    assert StartTimeConfig.get(proc_name, :database_pool_size) == @database_pool_size
  end

  describe "load/0" do
    test "HX_DATABASE_POOL_SIZE must be a positive integer" do
      env = "HX_DATABASE_POOL_SIZE"

      message = "#{env} must be a positive integer"

      Enum.each(["-1", "0", "1.0", "💩"], fn
        value ->
          System.put_env(env, value)

          assert {:error, ^message} = StartTimeConfig.load()
      end)
    end

    test "HX_DATABASE_POOL_SIZE defaults to a value of 10" do
      env = "HX_DATABASE_POOL_SIZE"

      System.delete_env(env)

      assert {:ok, %{database_pool_size: 10}} = StartTimeConfig.load()
    end

    test "HX_DATABASE_URL is required" do
      env = "HX_DATABASE_URL"

      message = "#{env} is required"

      System.delete_env(env)

      assert {:error, ^message} = StartTimeConfig.load()

      System.put_env(env, "")

      assert {:error, ^message} = StartTimeConfig.load()
    end

    test "HX_PORT must be a positive integer" do
      env = "HX_PORT"

      message = "#{env} must be a positive integer"

      Enum.each(["-1", "0", "1.0", "💩"], fn
        value ->
          System.put_env(env, value)

          assert {:error, ^message} = StartTimeConfig.load()
      end)
    end

    test "HX_PORT defaults to a value of 4000" do
      env = "HX_PORT"

      System.delete_env(env)

      assert {:ok, %{port: 4000}} = StartTimeConfig.load()
    end

    test "can load all configuration" do
      expected =
        Map.new()
        |> Map.put(:database_pool_size, @database_pool_size)
        |> Map.put(:database_url, @database_url)
        |> Map.put(:port, @port)
        |> Map.put(:secret_key, @secret_key)
        |> Map.put(:signing_salt, @signing_salt)

      assert {:ok, ^expected} = StartTimeConfig.load()
    end
  end

  test "to_env/1" do
    assert StartTimeConfig.to_env(:key) == "HX_KEY"
  end
end
