class CreateGasStations < ActiveRecord::Migration[6.0]
  def change
    create_table :gas_stations, id: false, :primary_key => :ideess do |t|
      t.string :cp
      t.string :address
      t.string :schedule
      t.float :latitude
      t.string :location
      t.float :longitude
      t.string :margin
      t.string :municipality
      t.string :price_biodiesel
      t.string :price_bioethanol
      t.string :price_compressed_natural_gas
      t.string :price_liquefied_natural_gas
      t.string :price_liquefied_petroleum_gases
      t.string :price_diesel_a
      t.string :price_diesel_b
      t.string :price_gasoline_95_protection
      t.string :price_gasoline_98
      t.string :price_new_diesel_a
      t.string :province
      t.string :remission
      t.string :label
      t.string :sale_type
      t.string :bioethanol
      t.string :methyl_ester
      t.integer :ideess
      t.string :id_municipality
      t.string :id_province
      t.string :idccaa
      t.datetime :updated_at
    end


    add_index(:gas_stations, :ideess, unique: true)


  end
end