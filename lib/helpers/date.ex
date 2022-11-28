defmodule Harvester.Helpers.Date do
  @moduledoc """
  Helper functions for working with dates.
  """

  alias Date, as: NativeDate

  @doc """
  Returns the month's first and last days.
  """
  @spec get_month_range(Date.t()) :: {Date.t(), Date.t()}
  def get_month_range(date) do
    first_day = date |> NativeDate.beginning_of_month() |> format()
    last_day = date |> NativeDate.end_of_month() |> format()

    {first_day, last_day}
  end

  @doc """
  Returns the first day of the previous month
  """
  @spec get_previous_month() :: Date.t()
  def get_previous_month do
    NativeDate.utc_today()
    |> NativeDate.beginning_of_month()
    |> NativeDate.add(-1)
    |> NativeDate.beginning_of_month()
  end

  @doc """
  Formats the date using ISO 8601 standard.
  """
  @spec format(Date.t()) :: String.t()
  def format(date), do: format(date, :long)
  def format(date, :short), do: date |> NativeDate.to_iso8601() |> String.slice(0..6)
  def format(date, :long), do: date |> NativeDate.to_iso8601() |> String.slice(0..9)
end
