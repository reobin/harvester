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
    |> add_query_params(params)
    |> HTTPoison.get!(add_default_headers(headers))
    |> decode_body()
  end

  @type headers :: list({String.t(), String.t()})
  @spec add_default_headers(headers) :: headers
  defp add_default_headers(headers), do: [{"Accept", "application/json"} | headers]

  @spec add_query_params(String.t(), map()) :: String.t()
  defp add_query_params(url, params),
    do: url |> URI.parse() |> Map.put(:query, URI.encode_query(params)) |> URI.to_string()

  @spec decode_body(map()) :: map()
  defp decode_body(%{body: body}), do: body |> Jason.decode!() |> MapHelper.atomize_keys()
  defp decode_body(_response), do: nil
end
