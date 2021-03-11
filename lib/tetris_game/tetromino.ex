defmodule Tetris.Tetromino do
  alias Tetris.Point
  defstruct shape: :l, rotation: 90, location: {5, 0}

  def new(options \\ []) do
    __struct__(options)
  end

  def new_random do
    new(shape: random_shape(), rotation: random_rotation())
  end

  def right(piece), do: %{ piece | location: Point.right(piece.location)}
  def left(piece),  do: %{ piece | location: Point.left(piece.location) }
  def down(piece),  do: %{ piece | location: Point.down(piece.location) }

  def rotate(piece) do
    %{ piece | rotation: rotate_clockwise(piece.rotation)}
  end

  defp rotate_clockwise(270), do: 0
  defp rotate_clockwise(degrees), do: degrees+90

  defp random_shape, do: randomizer [:o, :i, :l, :j, :z, :t]
  defp random_rotation, do: randomizer [0, 90, 180, 270]

  defp randomizer(list) do
     list
     |> Enum.shuffle
     |> hd
  end
end
