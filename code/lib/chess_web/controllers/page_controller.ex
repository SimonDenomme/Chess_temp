defmodule ChessWeb.PageController do
  @moduledoc false

  use ChessWeb, :controller

  import Chess.Auth, only: [current_user: 1]

  def index(conn, _params) do
    if current_user(conn) != nil do
      conn |> redirect(to: game_path(conn, :index)) |> halt()
    else
      render(conn, :index)
    end
  end

  def not_found(conn, _params) do
    render(conn, :not_found)
  end
end
