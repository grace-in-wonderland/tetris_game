defmodule TetrisGame.Repo do
  use Ecto.Repo,
    otp_app: :tetris_game,
    adapter: Ecto.Adapters.Postgres
end
