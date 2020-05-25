namespace :gas_stations do
  desc "Fetch the gas stations"
  task fetch: :environment do
    sleep(5.minutes)
    GasStation.import_gas_stations(ENV["URL_API"])
  end
end
