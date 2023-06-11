defmodule Hx.Auth.SessionFactory do
  alias Hx.Auth.Session

  def new(overrides \\ %{}) do
    %Session{}
    |> Map.put(:token, Session.gen_token())
    |> Map.merge(overrides)
  end
end
