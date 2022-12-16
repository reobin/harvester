defmodule Harvester.Helpers.Date do
  @moduledoc """
  Helper functions for working with dates.
  """

  @doc """
  Returns the month's first and last days.
  """
  @spec get_month_range(Date.t()) :: {Date.t(), Date.t()}
  def get_month_range(date) do
    first_day = date |> Date.beginning_of_month() |> format()
    last_day = date |> Date.end_of_month() |> format()

    {first_day, last_day}
  end

  @doc """
  Returns the first day of the previous month
  """
  @spec get_previous_month() :: Date.t()
  def get_previous_month do
    Date.utc_today()
    |> Date.beginning_of_month()
    |> Date.add(-1)
    |> Date.beginning_of_month()
  end

  @doc """
  Formats the date using ISO 8601 standard.
  """
  @spec format(Date.t()) :: String.t()
  def format(date), do: format(date, :long)
  def format(date, :short), do: date |> Date.to_iso8601() |> String.slice(0..6)
  def format(date, :long), do: date |> Date.to_iso8601() |> String.slice(0..9)

  @doc """
  Gets date from system arguments.
  """
  @spec from_args() :: Date.t() | nil
  def from_args() do
    try do
      [year, month] =
        System.argv() |> Enum.at(0) |> String.split("/") |> Enum.map(&String.to_integer/1)

      Date.new!(year, month, 1)
    rescue
      _ -> nil
    end
  end
end
