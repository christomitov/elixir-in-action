defmodule TodoList do
  defstruct next_id: 1, entries: %{}

  @moduledoc """
  Todolist abstraction
  """

  @doc """
  Instantiates a brand new todolist
  """
  def new(entries \\ []) do
    Enum.reduce(
      entries,
      %TodoList{},
      &add_entry(&2, &1)
    )
  end

  @doc """
  Add an entry to a provided todolist
  """
  def add_entry(todo_list, entry) do
    entry = Map.put(entry, :id, todo_list.next_id)
    new_entries = Map.put(todo_list.entries, todo_list.next_id, entry)
    %TodoList{todo_list | entries: new_entries, next_id: todo_list.next_id + 1}
  end

  @doc """
  Get entries for a specific date
  """
  def entries(todo_list, date) do
    todo_list.entries
    |> Map.values()
    |> Enum.filter(fn entry -> entry.date == date end)
  end

  @doc """
  Update a specific TodoList entry by id
  """
  def update_entry(todo_list, entry_id, updater_fun) do
    case Map.fetch(todo_list.entries, entry_id) do
      :error ->
        todo_list

      {:ok, old_entry} ->
        new_entry = updater_fun.(old_entry)
        put_in(todo_list.entries[entry_id], new_entry)
    end
  end

  @doc """
  Delete a specific TodoList entry by id
  """
  def delete_entry(todo_list, entry_id) do
    case Map.fetch(todo_list.entries, entry_id) do
      :error ->
        todo_list

      {:ok, _} ->
        new_entries = Map.drop(todo_list.entries, [entry_id])
        %TodoList{todo_list | entries: new_entries}
    end
  end
end
