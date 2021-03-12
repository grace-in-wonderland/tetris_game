defmodule Tetris.Tetromino do
  alias Tetris.{Point, Points}
  defstruct shape: :l, rotation: 90, location: {3, 0}

  def new(options \\ []) do
    __struct__(options)
  end

  def new_random do
    new(shape: random_shape(), rotation: random_rotation())
  end

  def right(piece), do: %{ piece | location: Point.right(piece.location)}
  def left(piece),  do: %{ piece | location: Point.left(piece.location) }
  def down(piece),  do: %{ piece | location: Point.down(piece.location) }

  def maybe_move(_old, new, true=valid), do: new
  def maybe_move(old, _new, false=valid), do: old

  def rotate(piece) do
    %{ piece | rotation: rotate_clockwise(piece.rotation)}
  end

  def show(piece) do
    piece
    |> points
    |> Points.rotate(piece.rotation)
    |> Points.move(piece.location)
    |> Points.add_shape(piece.shape)
  end

  def points(%{shape: :l}) do
    [
      {2, 1},
      {2, 2},
      {2, 3}, {3, 3}
    ]
  end

  def points(%{shape: :j}) do
    [
                 {3, 1},
                 {3, 2},
         {2, 3}, {3, 3}
    ]
  end

  def points(%{shape: :z}) do
    [
      {1, 2}, {2, 2},
              {2, 3}, {3, 3}
    ]
  end

  def points(%{shape: :s}) do
    [
              {2, 2}, {3, 2},
      {1, 3}, {2, 3}
    ]
  end

  def points(%{shape: :o}) do
    [
      {2, 2}, {3, 2},
      {2, 3}, {3, 3}
    ]
  end

  def points(%{shape: :t}) do
    [{1, 2}, {2, 2}, {3, 2},
             {2, 3}]
  end

  def points(%{shape: :i}) do
    [
        {2, 1},
        {2, 2},
        {2, 3},
        {2, 4}
    ]
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
