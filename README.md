# Harvester

Generate an invoice from time logged in [Harvest](https://www.getharvest.com/).

## Set up

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
