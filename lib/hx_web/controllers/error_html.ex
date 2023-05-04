defmodule HxWeb.ErrorHTML do
  use HxWeb.HTML

  import Phoenix.Controller,
    only: [
      get_csrf_token: 0,
      status_message_from_template: 1
    ]

  embed_templates "error_html/*"

  def render(_template, assigns) do
    error(assigns)
  end

  @doc """
  Returns an error message based on on the provided HTTP status code.
  """
  @spec status_message(pos_integer) :: String.t()
  def status_message(404) do
    "Page not found"
  end

  def status_message(status_code) do
    "#{status_code}.html"
    |> status_message_from_template()
    |> String.capitalize()
  end
end
