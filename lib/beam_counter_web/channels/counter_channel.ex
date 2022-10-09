defmodule BeamCounterWeb.CounterChannel do
  use LiveState.Channel, web_module: BeamCounterWeb
  alias BeamCounter.Counter
  alias Phoenix.PubSub

  @impl true
  def init(_channel, _payload, _socket) do
    PubSub.subscribe(BeamCounter.PubSub, "count")

    {:ok, %{count: Counter.value()}}
  end

  @impl true
  def handle_event("increment", _, state) do
    Counter.increment()
    {:noreply, state}
  end

  @impl true
  def handle_message({:count, n}, state) do
    {:noreply, %{count: n}}
  end
end
