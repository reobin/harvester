defmodule Harvester.Modules.Harvest do
  @moduledoc """
  This module is responsible for interactions with the Harvest API.
  """

  alias Harvester.Modules.HTTP

  alias Harvester.Helpers.Map, as: MapHelper

  @harvest_api_url "https://api.harvestapp.com/v2"

  @type auth :: %{access_token: String.t(), account_id: String.t()}
  @type user :: %{id: integer(), first_name: String.t(), last_name: String.t(), email: String.t()}

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
  @spec list_time_entries!(auth, map()) :: [map()]
  def list_time_entries!(auth, options \\ []) do
    default_options = %{user_id: nil, from: "2022-01-01", to: "2023-01-01"}
    params = Enum.into(options, default_options)

    headers = build_headers(auth)

    "#{@harvest_api_url}/time_entries"
    |> HTTP.get!(headers, params)
    |> Map.get(:time_entries, [])
  end

  @spec build_headers(auth) :: list()
  defp build_headers(auth),
    do: [
      {"Harvest-Account-Id", auth.account_id},
      {"Authorization", "Bearer #{auth.api_token}"}
    ]
end
