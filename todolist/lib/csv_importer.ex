defmodule TodoList.CsvImporter do
  @moduledoc """
  Create a TodoList instance from a CSV in the format of 
  date, task

  ex:
  2023-12-19,Dentist
  2023-12-20,Shopping
  2023-12-19,Movies
  """

  @doc """
  Return a TodoList from a provided path
  """
  def import(path) do
    path
    |> File.stream!()
    |> Stream.map(&String.trim_trailing(&1, "\n"))
    |> Stream.map(&String.split(&1, ","))
    |> Stream.map(fn [date_string, title] -> [Date.from_iso8601!(date_string), title] end)
    |> Stream.map(fn [date, title] -> %{date: date, title: title} end)
    |> Enum.to_list()
    |> TodoList.new()
  end
end
