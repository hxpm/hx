defmodule HxWeb.Components.Input do
  use Phoenix.Component

  attr :disabled, :boolean, default: false

  attr :id, :string, default: nil

  attr :field, Phoenix.HTML.FormField

  attr :name, :string, default: nil

  attr :rest, :global, include: ["autocomplete"]

  attr :type, :string, default: nil

  attr :value, :string, default: nil

  def input(%{field: %Phoenix.HTML.FormField{} = field} = assigns) do
    assigns =
      assigns
      |> assign(:field, nil)
      |> assign(:id, field.id)
      |> assign(:name, field.name)

    input(assigns)
  end

  def input(assigns) do
    value = Phoenix.HTML.Form.normalize_value(assigns[:type], assigns[:value])

    assigns = assign(assigns, :value, value)

    ~H"""
    <input
      class={[
        "block border-0 ring-1 ring-inset ring-gray-300 rounded-md py-1.5 shadow-sm text-gray-900 w-full",
        "disabled:bg-gray-50 disabled:cursor-not-allowed disabled:ring-gray-200 disabled:text-gray-500",
        "focus:ring-2 focus:ring-indigo-600 focus:ring-inset",
        "placeholder:text-gray-400",
        "sm:leading-6 sm:text-sm"
      ]}
      disabled={@disabled}
      id={@id}
      name={@name}
      type={@type}
      value={@value}
      {@rest}
    />
    """
  end
end
