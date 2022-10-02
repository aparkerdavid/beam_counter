defmodule BeamCounter.Counter do
  use Agent
  alias Phoenix.PubSub

  def start_link(initial_value) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  def value do
    Agent.get(__MODULE__, & &1)
  end

  def increment do
    Agent.update(__MODULE__, fn prev ->
      count = prev + 1
      PubSub.broadcast(BeamCounter.PubSub, "count", {:count, count})
      count
    end)
  end
end
