ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(Chess.Repo, {:shared, self()})

{:ok, _} = Application.ensure_all_started(:wallaby)
Application.put_env(:wallaby, :base_url, ChessWeb.Endpoint.url())
