defmodule Harvester.Modules.Harvest do
  @moduledoc """
  This module is responsible for interactions with the Harvest API.
  """

  alias Harvester.Modules.HTTP

  @harvest_api_url "https://api.harvestapp.com/v2"

  @type auth :: %{access_token: String.t(), account_id: String.t()}
  @type user :: %{id: integer(), first_name: String.t(), last_name: String.t(), email: String.t()}
  @type time_entry :: %{hours: float()}

  @doc """
  Returns a user's Harvest account information.
  """
  @spec get_authenticated_user!(auth) :: user
  def get_authenticated_user!(auth),
    do: HTTP.get!("#{@harvest_api_url}/users/me", build_headers(auth))

  @doc """
  Returns all time entries based on parameters.
  """
  @spec list_time_entries!(auth, list()) :: [time_entry]
  def list_time_entries!(auth, options \\ []) do
    default_options = %{user_id: nil, from: "2022-01-01", to: "2023-01-01", page: 1}
    params = Enum.into(options, default_options)

    headers = build_headers(auth)

    result = "#{@harvest_api_url}/time_entries" |> HTTP.get!(headers, params)

    if result.total_pages > result.page do
      params = params |> Map.put(:page, result.page + 1) |> Map.to_list()
      result.time_entries ++ list_time_entries!(auth, params)
    else
      result.time_entries
    end
  end

  @type headers :: list({String.t(), String.t()})
  @spec build_headers(auth) :: headers
  defp build_headers(%{account_id: account_id, api_token: api_token}),
    do: [{"Harvest-Account-Id", account_id}, {"Authorization", "Bearer #{api_token}"}]

  defp build_headers(_auth), do: []
end
