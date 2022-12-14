defmodule BeamCounterWeb.Live.Counter do
  use BeamCounterWeb, :live_view
  alias BeamCounter.Counter
  alias Phoenix.PubSub

  @impl true
  def render(assigns) do
    ~H"""
    <div class="center">
      <button phx-click="increment"><%= @count %></button>
    </div>
    """
  end

  @impl true
  def mount(_, _, socket) do
    PubSub.subscribe(BeamCounter.PubSub, "count")
    count = Counter.value()

    socket
    |> assign(count: count)
    |> then(&{:ok, &1})
  end

  @impl true
  def handle_info({:count, n}, socket) do
    socket
    |> assign(count: n)
    |> then(&{:noreply, &1})
  end

  @impl true
  def handle_event("increment", _, socket) do
    Counter.increment()
    {:noreply, socket}
  end
end
