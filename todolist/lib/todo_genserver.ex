defmodule TodoGenServer do
  use GenServer
  alias TodoList

  def start() do
    GenServer.start(__MODULE__, nil, name: __MODULE__)
  end

  def add_entry(entry), do: GenServer.cast(__MODULE__, {:add_entry, entry})
  def update_entry(id, updater), do: GenServer.cast(__MODULE__, {:update_entry, id, updater})
  def delete_entry(id), do: GenServer.cast(__MODULE__, {:delete_entry, id})
  def entries(date), do: GenServer.call(__MODULE__, {:entries, date})

  @impl GenServer
  def init(_) do
    {:ok, TodoList.new()}
  end

  @impl GenServer
  def handle_cast({:add_entry, new_entry}, todo_list) do
    {:noreply, TodoList.add_entry(todo_list, new_entry)}
  end

  @impl GenServer
  def handle_cast({:update_entry, entry_id, updater_fun}, todo_list) do
    {:noreply, TodoList.update_entry(todo_list, entry_id, updater_fun)}
  end

  @impl GenServer
  def handle_cast({:delete_entry, entry_id}, todo_list) do
    {:noreply, TodoList.delete_entry(todo_list, entry_id)}
  end

  @impl GenServer
  def handle_call({:entries, date}, _, todo_list) do
    {:reply, TodoList.entries(todo_list, date), todo_list}
  end
end
