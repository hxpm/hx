defmodule Hx.ConfigTest do
  use ExUnit.Case, async: false

  @valid %{database_url: "postgres://postgres:postgres@hx-db:5432/hx"}

  test "to_env/1" do
    assert Hx.Config.to_env(:database_url) == "HX_DATABASE_URL"
  end

  describe "validate/1" do
    test "ok" do
      :ok = Hx.Config.validate(@valid)
    end

    test "HX_DATABASE_URL is required" do
      config = Map.drop(@valid, [:database_url])

      {:error, "HX_DATABASE_URL is required."} = Hx.Config.validate(config)
    end
  end
end
