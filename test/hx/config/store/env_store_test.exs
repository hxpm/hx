defmodule Hx.Config.EnvStoreTest do
  use ExUnit.Case, async: true

  alias Hx.Config.EnvStore

  setup do
    config_name = Hx.Fab.string()

    config_key = String.to_atom(config_name)

    env_name = "HX_#{String.upcase(config_name)}"

    env_value = Hx.Fab.string()

    System.put_env(env_name, env_value)

    on_exit(fn -> System.delete_env(env_name) end)

    %{config_key: config_key, config_name: config_name, env_name: env_name, env_value: env_value}
  end

  test "all/1", %{config_key: config_key, env_value: env_value} do
    assert EnvStore.all(config_keys: [config_key]) == {:ok, [{config_key, env_value}]}
  end

  test "get/1", %{config_key: config_key, env_value: env_value} do
    assert EnvStore.get(config_key) == env_value
  end

  test "to_env/1", %{config_key: config_key, env_name: env_name} do
    assert EnvStore.to_env(config_key) == env_name
  end
end
