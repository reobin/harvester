defmodule Harvester.Modules.HTTP do
  @moduledoc """
  A simple HTTP service.
  """

  alias Harvester.Helpers.Map, as: MapHelper

  @doc """
  Returns the body of a GET request to the given URL.
  """
  @spec get!(String.t()) :: map()
  def get!(url), do: get!(url, [], %{})

  @spec get!(String.t(), list()) :: map()
  def get!(url, headers), do: get!(url, headers, %{})

  @spec get!(String.t(), list(), map()) :: map()
  def get!(url, headers, params) do
    url
    |> URI.parse()
    |> Map.put(:query, URI.encode_query(params))
    |> URI.to_string()
    |> HTTPoison.get!([{"Accept", "application/json"} | headers])
    |> then(& &1.body)
    |> Jason.decode!()
    |> MapHelper.atomize_keys()
  end
end
