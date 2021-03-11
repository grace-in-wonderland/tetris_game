defmodule Tetris.Points do
  alias Tetris.Point

  def move(points, {x,y}) do
    points
    |> Enum.map(&Point.move(&1, {x,y}))
  end

  def add_shape(points, shape) do
    points
    |> Enum.map(&Point.add_shape(&1, shape))
  end
end
