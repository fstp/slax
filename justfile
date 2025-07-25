alias d := docker
alias s := start_server
alias tw := tailwind_rebuild

docker:
    cd docker && docker compose up -d --remove-orphans

start_server:
    iex -S mix phx.server

seed:
    mix run priv/repo/seeds.exs

tailwind_rebuild:
    mix assets.build
