defmodule TetrisGameWeb.GameLive.GameOver do
  use TetrisGameWeb, :live_view
  alias Tetris.Game

  def mount(_params, _session, socket) do
    {:ok,  socket}
  end



end
