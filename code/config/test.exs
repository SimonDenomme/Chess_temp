use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :chess, ChessWeb.Endpoint,
  check_origin: false,
  http: [port: 4001],
  server: true

config :chess, :sandbox, Ecto.Adapters.SQL.Sandbox

# Print only warnings and errors during test
config :logger, level: :warn

config :chess, Chess.Mailer, adapter: Bamboo.TestAdapter

# Configure Wallaby
config :wallaby,
  driver: Wallaby.Chrome,
  otp_app: :chess,
  screenshot_on_failure: true,
  screenshot_dir: "test/screenshots",
  # chromedriver: [ path: "C:/Program Files (x86)/Google/Chrome/Application/chromedriver.exe"]
  # chromedriver: [ path: "D:Simon/Ecole/Session22A/Distribué/TP/chess/code/test/chrome/chromedriver.exe"]
  chromedriver: [path: "test/chrome/chromedriver.exe"]

# Configure your database
config :chess, Chess.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "chess_dev",
  hostname: "localhost",
  username: "postgres",
  password: "postgres",
  port: System.get_env("POSTGRES_PORT") || "5432",
  pool: Ecto.Adapters.SQL.Sandbox
