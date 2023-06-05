defmodule HxWeb.Components.Label do
  use Phoenix.Component

  attr :field, Phoenix.HTML.FormField

  attr :for, :string, default: nil

  attr :rest, :global

  slot :inner_block, required: true

  def label(%{field: %Phoenix.HTML.FormField{} = field} = assigns) do
    assigns =
      assigns
      |> assign(:field, nil)
      |> assign(:for, field.id)

    label(assigns)
  end

  def label(assigns) do
    ~H"""
    <label class="block font-medium leading-6 text-gray-900 text-sm" for={@for} {@rest}>
      <%= render_slot(@inner_block) %>
    </label>
    """
  end
end
