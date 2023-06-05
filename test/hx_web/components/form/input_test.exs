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

  test "supports disabled attribute" do
    assigns = %{}

    template = ~H"<.input disabled />"

    [disabled] =
      template
      |> rendered_to_string()
      |> Floki.parse_document!()
      |> Floki.attribute("input", "disabled")

    assert disabled
  end

  test "when the error slot is present an error is rendered" do
    assigns = %{error: "👎", id: "input"}

    template = ~H"""
    <.input id={@id}>
      <:error><%= @error %></:error>
    </.input>
    """

    error =
      template
      |> rendered_to_string()
      |> Floki.parse_document!()
      |> Floki.find("p#" <> assigns[:id] <> "_error")
      |> Floki.text()

    assert error =~ assigns[:error]
  end

  test "when the error slot is present the aria-describedby attribute is automatically added" do
    assigns = %{error: "👎", id: "input"}

    template = ~H"""
    <.input id={@id}>
      <:error><%= @error %></:error>
    </.input>
    """

    [aria_describedby] =
      template
      |> rendered_to_string()
      |> Floki.parse_document!()
      |> Floki.attribute("input", "aria-describedby")

    assert aria_describedby == assigns[:id] <> "_error"
  end

  test "when the error slot is present the aria-invalid attribute is automatically added" do
    assigns = %{error: "👎", id: "input"}

    template = ~H"""
    <.input id={@id}>
      <:error><%= @error %></:error>
    </.input>
    """

    [aria_invalid] =
      template
      |> rendered_to_string()
      |> Floki.parse_document!()
      |> Floki.attribute("input", "aria-invalid")

    assert aria_invalid
  end

  test "supports id attribute" do
    assigns = %{id: "input"}

    template = ~H"<.input id={@id} />"

    [id] =
      template
      |> rendered_to_string()
      |> Floki.parse_document!()
      |> Floki.attribute("input", "id")

    assert id == assigns[:id]
  end

  test "when the field attribute is present the id attribute is automatically added" do
    form =
      %Hx.Identity.User{}
      |> Ecto.Changeset.cast(%{}, [])
      |> to_form()

    assigns = %{form: form}

    template = ~H"<.input field={@form[:email]} />"

    [id] =
      template
      |> rendered_to_string()
      |> Floki.parse_document!()
      |> Floki.attribute("input", "id")

    assert id == assigns[:form][:email].id
  end

  test "when the field attribute is present the name attribute is automatically added" do
    form =
      %Hx.Identity.User{}
      |> Ecto.Changeset.cast(%{}, [])
      |> to_form()

    assigns = %{form: form}

    template = ~H"<.input field={@form[:email]} />"

    [name] =
      template
      |> rendered_to_string()
      |> Floki.parse_document!()
      |> Floki.attribute("input", "name")

    assert name == assigns[:form][:email].name
  end

  test "supports name attribute" do
    assigns = %{name: "input"}

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
