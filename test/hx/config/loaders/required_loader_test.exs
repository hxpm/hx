defmodule Hx.Config.RequiredLoaderTest do
  use ExUnit.Case, async: true

  alias Hx.Config.RequiredLoader

  @message "is required"

  test "returns an error if the value is nil" do
    assert {:error, @message} = RequiredLoader.load(nil)
  end

  test "returns an error if the value is an empty string" do
    assert {:error, @message} = RequiredLoader.load("")
  end
end
