defmodule HxWeb.Components.Button do
  use Phoenix.Component

  attr :class, :string,
    default: nil,
    doc: "CSS classes"

  attr :rest, :global

  slot :inner_block

  def button(assigns) do
    ~H"""
    <button
      class={[
        "bg-indigo-600 font-semibold px-3 py-2 rounded-md shadow-sm text-sm text-white",
        "focus-visible:outline-indigo-600 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2",
        "hover:bg-indigo-500",
        @class
      ]}
      {@rest}
    >
      <%= render_slot(@inner_block) %>
    </button>
    """
  end
end
