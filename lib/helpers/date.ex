defmodule Harvester.Helpers.Date do
  @moduledoc """
  Helper functions for working with dates.
  """

  alias Date, as: NativeDate

  @doc """
  Returns the current month's first and last days.
  """
  @spec get_current_month_range() :: {Date.t(), Date.t()}
  def get_current_month_range do
    first_day = NativeDate.utc_today() |> NativeDate.beginning_of_month() |> format()
    last_day = NativeDate.utc_today() |> NativeDate.end_of_month() |> format()

    {first_day, last_day}
  end

  @spec format(Date.t()) :: String.t()
  defp format(date), do: date |> NativeDate.to_iso8601() |> String.slice(0..9)
end
