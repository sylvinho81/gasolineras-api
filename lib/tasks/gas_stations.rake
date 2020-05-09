namespace :gas_stations do
  desc "Fetch the gas stations from sedeaplicaciones.minetur.gob.es"
  task fetch: :environment do
    GasStation.import_gas_stations
  end
end
