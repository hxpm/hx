defmodule Hx.Config.PositiveIntegerLoaderTest do
  use ExUnit.Case, async: true

  alias Hx.Config.PositiveIntegerLoader

  @message "must be a positive integer"

  test "returns an error if the value is a string" do
    assert {:error, @message} = PositiveIntegerLoader.load("💩")
  end

  test "returns an error if the value is -1" do
    assert {:error, @message} = PositiveIntegerLoader.load("-1")
  end

  test "returns an error if the value is 0" do
    assert {:error, @message} = PositiveIntegerLoader.load("0")
  end

  test "returns an error if the value is 1.0" do
    assert {:error, @message} = PositiveIntegerLoader.load("1.0")
  end

  test "returns an integer if the value is a positive integer" do
    assert {:ok, 1} = PositiveIntegerLoader.load("1")
  end

  test "returns a default value if the value is nil" do
    assert {:ok, 1} = PositiveIntegerLoader.load(nil, 1)
  end
end
