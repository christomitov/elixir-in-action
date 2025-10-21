defmodule Todo.Server do
  use GenServer

  def start() do
    GenServer.start(__MODULE__, nil)
  end

  def add_entry(pid, new_entry), do: GenServer.cast(pid, {:add_entry, new_entry})

  def update_entry(pid, entry_id, updater_fun),
    do: GenServer.cast(pid, {:update_entry, entry_id, updater_fun})

  def delete_entry(pid, entry_id), do: GenServer.cast(pid, {:delete_entry, entry_id})
  def entries(pid, date), do: GenServer.call(pid, {:entries, date})

  @impl GenServer
  def init(_) do
    {:ok, Todo.List.new()}
  end

  @impl GenServer
  def handle_cast({:add_entry, new_entry}, todo_list) do
    {:noreply, Todo.List.add_entry(todo_list, new_entry)}
  end

  @impl GenServer
  def handle_cast({:update_entry, entry_id, updater_fun}, todo_list) do
    {:noreply, Todo.List.update_entry(todo_list, entry_id, updater_fun)}
  end

  @impl GenServer
  def handle_cast({:delete_entry, entry_id}, todo_list) do
    {:noreply, Todo.List.delete_entry(todo_list, entry_id)}
  end

  @impl GenServer
  def handle_call({:entries, date}, _, todo_list) do
    {:reply, Todo.List.entries(todo_list, date), todo_list}
  end
end
