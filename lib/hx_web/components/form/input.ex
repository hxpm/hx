defmodule HxWeb.Components.Input do
  use Phoenix.Component

  attr :id, :string, default: nil

  attr :rest, :global, include: ["autocomplete", "name"]

  attr :type, :string, default: nil

  attr :value, :string, default: nil

  def input(assigns) do
    value = Phoenix.HTML.Form.normalize_value(assigns[:type], assigns[:value])

    assigns = assign(assigns, :value, value)

    ~H"""
    <input
      class={[
        "block border-0 ring-1 ring-inset ring-gray-300 rounded-md py-1.5 shadow-sm text-gray-900 w-full",
        "focus:ring-2 focus:ring-indigo-600 focus:ring-inset",
        "placeholder:text-gray-400",
        "sm:leading-6 sm:text-sm"
      ]}
      id={@id}
      type={@type}
      value={@value}
      {@rest}
    />
    """
  end
end
