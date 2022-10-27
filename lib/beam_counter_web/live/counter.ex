defmodule BeamCounterWeb.Live.Counter do
  use BeamCounterWeb, :live_view
  alias BeamCounter.Counter
  alias Phoenix.PubSub

  @impl true
  def render(assigns) do
    ~H"""
     <button phx-click="increment"><%= @count %></button>
    """
  end

  @impl true
  def mount(_, _, socket) do
    PubSub.subscribe(BeamCounter.PubSub, "count")

    socket
    |> assign(count: Counter.value())
    |> then(&{:ok, &1})
  end

  @impl true
  def handle_event("increment", _, socket) do
    Counter.increment()
    {:noreply, socket}
  end

  @impl true
  def handle_info({:count, n}, socket) do
    socket
    |> assign(count: n)
    |> then(&{:noreply, &1})
  end
end
