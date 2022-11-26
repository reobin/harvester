# Harvester

- [Harvester](#harvester)
  - [Requirements](#requirements)
    - [Harvest API](#harvest-api)
  - [Get started](#get-started)
  - [Get started (docker)](#get-started--docker-)

## Requirements

- [mix (elixir)](https://elixir-lang.org/install.html)
  - or [Docker](https://docs.docker.com/get-docker/)

### Harvest API

Some variables are needed for this script to authenticate to the Harvest API:

- Harvest account ID
- Harvest API token

Copy the example config file and fill the values:

```sh
cp config/example.secrets.exs config/secrets.exs
```

## Get started

Install dependencies:

```sh
mix deps.get
```

Run the script:

```sh
mix harvester.run
```

## Get started (docker)

Build the container:

```sh
docker build -t harvester .
```

Run the script:

```sh
docker run harvester
```
