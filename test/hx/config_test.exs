defmodule Hx.ConfigTest do
  use ExUnit.Case, async: false

  test "to_env/1" do
    assert Hx.Config.to_env(:database_url) == "HX_DATABASE_URL"
  end
end
