class AddIndexesSearch < ActiveRecord::Migration[6.0]
  def change
    add_index(:gas_stations, :municipality)
    add_index(:gas_stations, :location)
    add_index(:gas_stations, :province)
    add_index(:gas_stations, :address)
  end
end
