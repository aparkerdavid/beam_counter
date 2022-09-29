defmodule BeamCounterWeb.PageController do
  use BeamCounterWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
