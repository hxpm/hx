defmodule Hx.Config.SystemSettingTest do
  use Hx.DataCase, async: true

  alias Hx.Config.SystemSetting
  alias Hx.Config.SystemSettingFactory

  test "all/0" do
    Hx.Repo.delete_all(SystemSetting)

    system_setting = SystemSettingFactory.new() |> Hx.Repo.insert!()

    assert [^system_setting] = SystemSetting.all()
  end

  describe "create_or_update/2" do
    test ":key is required" do
      assert_raise Ecto.InvalidChangesetError,
                   ~r/%{key: \[{".+", \[validation: :required\]}\]}/,
                   fn ->
                     SystemSetting.create_or_update!(nil, "📈")
                   end
    end

    test ":value is required" do
      assert_raise Ecto.InvalidChangesetError,
                   ~r/%{value: \[{".+", \[validation: :required\]}\]}/,
                   fn ->
                     SystemSetting.create_or_update!("🔑", nil)
                   end
    end

    test "creates a system setting" do
      Hx.Repo.delete_all(SystemSetting)

      assert Hx.Repo.aggregate(SystemSetting, :count) == 0

      assert %SystemSetting{} = SystemSetting.create_or_update!("🔑", "📈")

      assert Hx.Repo.aggregate(SystemSetting, :count) == 1
    end

    test "updates a system setting" do
      system_setting =
        %{value: "old 📈"}
        |> SystemSettingFactory.new()
        |> Hx.Repo.insert!()

      key = system_setting.key
      value = "new 📈"

      assert %SystemSetting{
               key: ^key,
               value: ^value
             } = SystemSetting.create_or_update!(key, value)
    end
  end
end
