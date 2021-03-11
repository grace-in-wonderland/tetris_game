defmodule TetrisGameWeb.GameLive do
  use TetrisGameWeb, :live_view
  alias Tetris.Tetromino

  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(500, :tick)
    end
    {:ok,
      socket
      |> new_tetromino
      |> show
    }
  end

  def render(assigns) do
    ~L"""
    <% {x, y} = @tetromino.location %>
    <section class="phx-hero">
      <h1>Welcome to Tetris</h1>
      <%= render_board(assigns) %>
      <pre>
        <%= inspect @tetromino %>
      </pre>
    </section>
    """
  end

  defp render_board(assigns) do
    ~L"""
    <svg width="200" height="400">
      <rect width="200" height="400" style="fill:black;" />
      <%= render_points(assigns) %>
    </svg>
    """
  end

  defp render_points(assigns) do
    ~L"""
    <%= for {x, y, shape} <- @points do %>
    <rect
      width="20" height="20"
      x="<%= (x - 1) * 20 %>" y="<%= (y - 1) * 20 %>"
      style="fill: <%= color(shape) %>;" />
    <% end %>
    """
  end

  defp color(:l), do: "red"
  defp color(:j), do: "blue"
  defp color(:z), do: "purple"
  defp color(:s), do: "green"
  defp color(:o), do: "yellow"
  defp color(:t), do: "white"
  defp color(_), do: "black"

  defp new_tetromino(socket) do
    assign(socket, tetromino: Tetromino.new_random())
  end

  defp show(socket) do
    assign(socket,
      points: Tetromino.show(socket.assigns.tetromino))
  end

  def down(%{assigns: %{tetromino: %{location: {_, 20}}}}=socket) do
    new_tetromino(socket)
  end

  def down(%{assigns: %{tetromino: piece}}=socket) do
    assign(socket, tetromino: Tetromino.down(piece))
  end

  def handle_info(:tick, socket) do
    {:noreply, socket |> down |> show}
  end
end