defmodule Harvester.Helpers.Map do
  @moduledoc """
  This module contains helper functions for working with maps.
  """

  @doc """
  Converts all keys in a map to atoms.
  """
  @spec atomize_keys(map()) :: map()
  def atomize_keys(map) when is_map(map),
    do: for({key, val} <- map, into: %{}, do: {String.to_atom(key), atomize_keys(val)})

  @spec atomize_keys(list()) :: list()
  def atomize_keys(list) when is_list(list), do: list |> Enum.map(&atomize_keys/1)
  @spec atomize_keys(any()) :: any()
  def atomize_keys(value), do: value
end
