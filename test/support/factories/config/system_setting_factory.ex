defmodule Hx.Config.SystemSettingFactory do
  alias Hx.Config.SystemSetting

  def new(overrides \\ %{}) do
    %SystemSetting{}
    |> Map.put(:key, "key")
    |> Map.put(:value, "value")
    |> Map.merge(overrides)
  end
end
