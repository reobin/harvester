# Harvester

> Aggregate hours logged in Harvest in order to generate an invoice.

## Table of contents

- [Requirements](#requirements)
  - [Harvest API](#harvest-api)
- [Get started](#get-started)
- [Get started (docker)](#get-started-docker)
- [CLI](#cli)

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

## CLI

### Aggregate time entries for a specific month

```sh
mix harvester.run 2022-12 # get time entries for December 2022
```

### Aggregate time entries between two dates

```sh
mix harvester.run --from 2022-12-01 --to 2022-12-31
```
