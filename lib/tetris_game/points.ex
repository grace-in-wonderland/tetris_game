defmodule Tetris.Points do
  alias Tetris.Point

  def move(points, {x,y}) do
    points
    |> Enum.map(&Point.move(&1, {x,y}))
  end

  def rotate(points, degrees) do
    points
    |> Enum.map(fn point -> Point.rotate(point, degrees) end)
  end

  def add_shape(points, shape) do
    points
    |> Enum.map(&Point.add_shape(&1, shape))
  end

  def valid?(points, junkyard) do
    Enum.all?(points, &Point.valid?(&1, junkyard))
  end
end
