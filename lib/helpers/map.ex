defmodule Harvester.Helpers.Map do
  @moduledoc """
  This module contains helper functions for working with maps.
  """

  @doc """
  Converts all keys in a map to atoms.
  """
  @spec atomize_keys(map) :: map
  def atomize_keys(map), do: map |> Map.new(fn {k, v} -> {String.to_atom(k), v} end)

  @doc """
  Converts all keys in a map to strings.
  """
  @spec stringify_keys(map) :: map
  def stringify_keys(map), do: map |> Map.new(fn {k, v} -> {Atom.to_string(k), v} end)
end
