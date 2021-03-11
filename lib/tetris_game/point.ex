defmodule Tetris.Point do
  def origin(), do: {0, 0}
  def left({x,y}), do: {x-1, y}
  def right({x,y}), do: {x+1, y}
  def down({x,y}), do: {x, y+1}

  def move({x,y}, {change_x, change_y}) do
    {x + change_x, y + change_y}
  end

  def add_shape({x,y}, shape), do: {x, y, shape}
  def add_shape(point_with_shape, _shape), do: point_with_shape

end
