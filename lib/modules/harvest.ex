defmodule Harvester.Modules.Harvest do
  @moduledoc """
  This module is responsible for interactions with the Harvest API.
  """

  alias Harvester.Modules.HTTP

  @harvest_api_url "https://api.harvestapp.com/v2"

  @doc """
  Returns a user's Harvest account information.
  """
  @type user :: %{id: integer(), first_name: String.t(), last_name: String.t(), email: String.t()}
  @spec get_authenticated_user!(String.t(), String.t()) :: user
  def get_authenticated_user!(account_id, api_token) do
    headers = [{"Harvest-Account-Id", account_id}, {"Authorization", "Bearer #{api_token}"}]
    HTTP.get!("#{@harvest_api_url}/users/me", headers)
  end
end
