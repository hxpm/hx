defmodule HxWeb.Components.LabelTest do
  use HxWeb.ConnCase, async: true

  use Phoenix.Component

  import HxWeb.Components.Label

  import Phoenix.LiveViewTest

  test "it renders" do
    assigns = %{inner_block: "👍"}

    template = ~H"<.label><%= @inner_block %></.label>"

    html_tree =
      template
      |> rendered_to_string()
      |> Floki.parse_document!()
      |> Floki.find("label")

    inner_block = Floki.text(html_tree)

    assert [{"label", _, _}] = html_tree
    assert inner_block =~ assigns[:inner_block]
  end
end
