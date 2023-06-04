defmodule HxWeb.Components.Label do
  use Phoenix.Component

  attr :rest, :global, include: ["for"]

  slot :inner_block, required: true

  def label(assigns) do
    ~H"""
    <label class="block font-medium leading-6 text-gray-900 text-sm" {@rest}>
      <%= render_slot(@inner_block) %>
    </label>
    """
  end
end
