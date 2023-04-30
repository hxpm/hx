defmodule HxWeb do
  @doc """
  List of static directories used as verified paths.
  """
  @spec static_paths :: [String.t()]
  def static_paths do
    ~w(assets)
  end
end
