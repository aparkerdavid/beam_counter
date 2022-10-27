defmodule BeamCounterWeb.Live.CounterNative do
  use BeamCounterWeb, :live_view_native
  alias BeamCounterWeb.Live.Counter

  @impl true
  def render(assigns) do
    ~H"""
     <button phx-click="increment">
       <text><%= @count %></text>
     </button>
    """
  end

  defdelegate mount(url, params, socket), to: Counter
  defdelegate handle_event(name, params, socket), to: Counter
  defdelegate handle_info(payload, socket), to: Counter
end
