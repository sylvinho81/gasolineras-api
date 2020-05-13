class AddIndexLatitudeLongitude < ActiveRecord::Migration[6.0]
  def change

    add_index :gas_stations, [:latitude, :longitude]
    remove_index(:gas_stations, :municipality)
    remove_index(:gas_stations, :location)
    remove_index(:gas_stations, :province)
    remove_index(:gas_stations, :address)
  end
end
