defmodule Harvester.Helpers.Date do
  @moduledoc """
  Helper functions for working with dates.
  """

  @doc """
  Returns the month's first and last days.
  """
  @spec month_range(Date.t()) :: {Date.t(), Date.t()}
  def month_range(date), do: {Date.beginning_of_month(date), Date.end_of_month(date)}

  @doc """
  Returns the first day of the previous month
  """
  @spec previous_month() :: Date.t()
  def previous_month do
    Date.utc_today()
    |> Date.beginning_of_month()
    |> Date.add(-1)
    |> Date.beginning_of_month()
  end

  @doc """
  Formats the date using ISO 8601 standard.
  """
  @spec format(Date.t()) :: String.t()
  def format(date), do: date |> Date.to_iso8601() |> String.slice(0..9)

  @doc """
  Parses a month in format YYYY-MM to a date.
  """
  def parse_month!(month) do
    [year, month] = String.split(month, "-")
    Date.new!(String.to_integer(year), String.to_integer(month), 1)
  end
end
