import Config

config :harvester, :harvest,
  account_id: {:system, "HARVEST_ACCOUNT_ID", nil},
  api_token: {:system, "HARVEST_API_TOKEN", nil}

if File.exists?("config/secrets.exs") do
  import_config "secrets.exs"
end
