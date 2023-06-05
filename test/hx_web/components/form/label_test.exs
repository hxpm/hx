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

  test "when the field attribute is present the for attribute is automatically added" do
    form =
      %Hx.Identity.User{}
      |> Ecto.Changeset.cast(%{}, [])
      |> to_form()

    assigns = %{form: form, inner_block: "👍"}

    template = ~H"<.label field={@form[:email]}><%= @inner_block %></.label>"

    [label_for] =
      template
      |> rendered_to_string()
      |> Floki.parse_document!()
      |> Floki.attribute("label", "for")

    assert label_for == assigns[:form][:email].id
  end

  test "supports for attribute" do
    assigns = %{for: "🙋", inner_block: "👍"}

    template = ~H"<.label for={@for}><%= @inner_block %></.label>"

    [label_for] =
      template
      |> rendered_to_string()
      |> Floki.parse_document!()
      |> Floki.attribute("label", "for")

    assert label_for == assigns[:for]
  end
end
