FROM elixir:1.14-slim

WORKDIR /app

COPY mix.exs mix.lock ./

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get --only prod

RUN mix deps.compile

COPY . .

RUN mix compile

CMD ["mix", "harvester.run"]
