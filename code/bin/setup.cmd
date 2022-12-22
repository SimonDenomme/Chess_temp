echo "Removing previous build artifacts"
rd /s /q deps _build

echo "Installing dependencies and compiling" && mix local.hex --force && mix deps.get && mix deps.compile && mix compile & echo "Setting up the database" && mix ecto.create && mix ecto.migrate & echo "Installing js dependencies" & cd assets && npm install yarn && npm install esbuild & cd .. && mix assets.deploy
