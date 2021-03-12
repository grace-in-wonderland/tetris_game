defmodule TetrisGameWeb.GameLive.Welcome do
  use TetrisGameWeb, :live_view
  alias Tetris.Game

  def mount(_params, _session, socket) do
    {:ok,  socket}
  end

  defp play(socket) do
    push_redirect(socket, to: "/game/playing")
  end

  def handle_event("play", _, socket) do
    {:noreply, play(socket)}
  end

end
