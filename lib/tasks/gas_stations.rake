namespace :gas_stations do
  desc "Fetch the gas stations"
  task fetch: :environment do
    GasStation.import_gas_stations(ENV["URL_API"])
  end
end

