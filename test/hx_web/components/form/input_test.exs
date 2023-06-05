defmodule HxWeb.Components.InputTest do
  use HxWeb.ConnCase, async: true

  use Phoenix.Component

  import HxWeb.Components.Input

  import Phoenix.LiveViewTest

  test "it renders" do
    assigns = %{}

    template = ~H"<.input />"

    html_tree =
      template
      |> rendered_to_string()
      |> Floki.parse_document!()
      |> Floki.find("input")

    assert [{"input", _, _}] = html_tree
  end

  test "supports id attribute" do
    assigns = %{id: "👍"}

    template = ~H"<.input id={@id} />"

    [id] =
      template
      |> rendered_to_string()
      |> Floki.parse_document!()
      |> Floki.attribute("input", "id")

    assert id == assigns[:id]
  end

  test "supports name attribute" do
    assigns = %{name: "👍"}

    template = ~H"<.input name={@name} />"

    [name] =
      template
      |> rendered_to_string()
      |> Floki.parse_document!()
      |> Floki.attribute("input", "name")

    assert name == assigns[:name]
  end

  test "supports type attribute" do
    assigns = %{type: "text"}

    template = ~H"<.input type={@type} />"

    [type] =
      template
      |> rendered_to_string()
      |> Floki.parse_document!()
      |> Floki.attribute("input", "type")

    assert type == assigns[:type]
  end

  test "supports value attribute" do
    assigns = %{value: "👍"}

    template = ~H"<.input value={@value} />"

    [value] =
      template
      |> rendered_to_string()
      |> Floki.parse_document!()
      |> Floki.attribute("input", "value")

    assert value == assigns[:value]
  end
end
