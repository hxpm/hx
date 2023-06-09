defmodule HxWeb.Gettext do
  @moduledoc """
  `Gettext` for the Hx application.
  """

  use Gettext, otp_app: :hx

  @doc """
  Translate an error message.
  """
  @spec translate_error({String.t(), keyword}) :: String.t()
  def translate_error({msg, opts}) do
    if count = opts[:count] do
      Gettext.dngettext(HxWeb.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(HxWeb.Gettext, "errors", msg, opts)
    end
  end

  @doc """
  Translate error messages for the given field.
  """
  @spec translate_errors([{String.t(), keyword}], atom) :: list[String.t()]
  def translate_errors(errors, field) do
    for {^field, {msg, opts}} <- errors do
      translate_error({msg, opts})
    end
  end
end
