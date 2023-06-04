defmodule HxWeb.Component.InputTest do
  use HxWeb.ConnCase, async: true

  use Phoenix.Component

  import HxWeb.Components.Input

  import Phoenix.LiveViewTest

  test "it renders" do
    assigns = %{}

    template = ~H"<.input />"

    component =
      template
      |> rendered_to_string()
      |> Floki.parse_document!()
      |> Floki.find("input")

    assert [{"input", _, _}] = component
  end
end
