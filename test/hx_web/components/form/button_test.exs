defmodule HxWeb.Components.ButtonTest do
  use HxWeb.ConnCase, async: true

  use Phoenix.Component

  import HxWeb.Components.Button

  import Phoenix.LiveViewTest

  test "it renders" do
    assigns = %{inner_block: "👍"}

    template = ~H"<.button><%= @inner_block %></.button>"

    inner_block =
      template
      |> rendered_to_string()
      |> Floki.parse_document!()
      |> Floki.find("button")
      |> Floki.text()

    assert inner_block =~ assigns[:inner_block]
  end

  test "class attribute can be provided" do
    assigns = %{class: "💅", inner_block: "👍"}

    template = ~H"<.button class={@class}><%= @inner_block %></.button>"

    [class] =
      template
      |> rendered_to_string()
      |> Floki.parse_document!()
      |> Floki.attribute("button", "class")

    assert class =~ assigns[:class]
  end
end
