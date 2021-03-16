defmodule Tetris.Game do
  alias Tetris.{Tetromino, Points}
  defstruct [:tetromino, points: [], score: 0, junkyard: %{}, game_over: false]

  def new do
    __struct__()
    |> new_tetromino
    |> show
  end

  def new_tetromino(game) do
    %{game | tetromino: Tetromino.new_random() }
    |> show
  end

  def show(game) do
    %{game | points: Tetromino.show(game.tetromino) }
  end

  def rotate(game), do: game |> move(&Tetromino.rotate/1) |> show
  def right(game), do: game |> move(&Tetromino.right/1) |> show
  def left(game), do: game |> move(&Tetromino.left/1) |> show

  def down(game) do
      {old, new, valid} = move_data(game, &Tetromino.down/1)

      maybe_move(game, old, new, valid)
   end


  defp move(game, move_fn) do
    {old, new, valid} = move_data(game, move_fn)
    moved = Tetromino.maybe_move(old, new, valid)

    %{game| tetromino:  moved}
     |> show
  end

  defp move_data(game, move_fn) do
    old = game.tetromino
    new = game.tetromino |> move_fn.()

    valid =
      new
      |> Tetromino.show
      |> Points.valid?(game.junkyard)

    {old, new, valid}
  end

   defp maybe_move(game, _old, new, true=_valid) do
     %{game| tetromino:  new}
      |> show
   end

   defp maybe_move(game, old, _new, false=_valid) do
     game
     |> merge(old)
     |> new_tetromino
     |> show
     |> check_game_over
   end

   defp merge(game, old) do
     new_junkyard =
       old
       |> Tetromino.show
       |> Enum.map(fn {x, y, shape} -> {{x, y}, shape} end)
       |> Enum.into(game.junkyard)

       %{game| junkyard:  new_junkyard}
        |> collapse_rows
   end

   def collapse_rows(game) do
    rows = find_complete_rows(game)
    game |> absorb(rows)
   end

   def absorb(game, []), do: game
   def absorb(game, [y|ys]), do: remove_row(game, y) |> absorb(ys)

   def remove_row(game, row) do
      new_junkyard =
      game.junkyard
      |> Enum.reject(fn {{_x, y}, _shape} -> y == row end)
      |> Enum.map(fn {{x, y}, shape} -> {{x, maybe_move_y(y, row)}, shape} end)
      |> Map.new

      %{game| junkyard: new_junkyard}
   end

   defp maybe_move_y(y, row) when y < row, do: y + 1
   defp maybe_move_y(y, _row), do: y

   def find_complete_rows(game) do
      game.junkyard
      |> Map.keys
      |> Enum.group_by(&elem(&1, 1))
      |> Enum.filter(fn {_y, list} -> length(list) == 10 end)
      |> Enum.map(fn {y, _list} -> y end)
   end

   def junkyard_points(game) do
     game.junkyard
     |> Enum.map(fn {{x, y}, shape} -> {x, y, shape} end)
   end

   def check_game_over(game) do
     continue_game =
       game.tetromino
       |> Tetromino.show
       |> Points.valid?(game.junkyard)

     %{game |game_over: !continue_game}
   end

end
