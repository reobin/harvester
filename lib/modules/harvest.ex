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
  def get_authenticated_user!(auth) do
    headers = build_headers(auth)
    HTTP.get!("#{@harvest_api_url}/users/me", headers)
  end

  @doc """
  Returns all time entries based on parameters.
  """
  @spec list_time_entries!(auth, map()) :: [time_entry]
  def list_time_entries!(auth, options \\ []) do
    default_options = %{user_id: nil, from: "2022-01-01", to: "2023-01-01", page: 1}
    params = Enum.into(options, default_options)

    headers = build_headers(auth)

    result = "#{@harvest_api_url}/time_entries" |> HTTP.get!(headers, params)

    if result.total_pages > result.page do
      result.time_entries ++ list_time_entries!(auth, Map.put(params, :page, result.page + 1))
    else
      result.time_entries
    end
  end

  @spec build_headers(auth) :: list({String.t(), String.t()})
  defp build_headers(auth),
    do: [
      {"Harvest-Account-Id", auth.account_id},
      {"Authorization", "Bearer #{auth.api_token}"}
    ]
end
