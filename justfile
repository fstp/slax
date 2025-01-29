alias s := start_server
alias tw := tailwind_rebuild

start_server:
    iex -S mix phx.server

seed:
    mix run priv/repo/seeds.exs

tailwind_rebuild:
    mix assets.build
