defmodule Hx.Config.SystemSettingTest do
  use Hx.DataCase, async: true

  alias Hx.Config.SystemSetting
  alias Hx.Config.SystemSettingFactory

  test "all/0" do
    system_setting = SystemSettingFactory.new() |> Hx.Repo.insert!()

    assert [^system_setting] = SystemSetting.all()
  end

  describe "create/2" do
    test ":key is required" do
      assert_raise Ecto.InvalidChangesetError,
                   ~r/%{key: \[{".+", \[validation: :required\]}\]}/,
                   fn ->
                     SystemSetting.create!(nil, "value")
                   end
    end

    test ":key requires uniqueness" do
      %{key: key, value: value} = SystemSettingFactory.new() |> Hx.Repo.insert!()

      assert_raise Ecto.InvalidChangesetError,
                   ~r/constraint: :unique, constraint_name: "system_settings_key_index"/,
                   fn ->
                     SystemSetting.create!(key, value)
                   end
    end

    test ":value is required" do
      assert_raise Ecto.InvalidChangesetError,
                   ~r/%{value: \[{".+", \[validation: :required\]}\]}/,
                   fn ->
                     SystemSetting.create!("key", nil)
                   end
    end

    test "creates a system setting" do
      assert Hx.Repo.aggregate(SystemSetting, :count) == 0

      assert %SystemSetting{} = SystemSetting.create!("key", "value")

      assert Hx.Repo.aggregate(SystemSetting, :count) == 1
    end
  end
end
