defmodule Hx.Changeset do
  @moduledoc """
  Functions for managing Ecto changesets.
  """

  @doc """
  Rmoves all errors for the given field from the changeset.
  """
  @spec remove_errors(Ecto.Changeset.t(), atom()) :: Ecto.Changeset.t()
  def remove_errors(%Ecto.Changeset{errors: errors} = changeset, field) do
    %{changeset | errors: Keyword.delete(errors, field)}
  end
end
