defmodule Harvester.Modules.HTTP do
  @moduledoc """
  A simple HTTP service.
  """

  alias Harvester.Helpers.Map

  @doc """
  Returns the body of a GET request to the given URL.
  """
  @spec get!(String.t(), list()) :: map()
  def get!(url, headers \\ []) do
    url
    |> HTTPoison.get!([{"Accept", "application/json"} | headers])
    |> then(& &1.body)
    |> Jason.decode!()
    |> Map.atomize_keys()
  end
end
