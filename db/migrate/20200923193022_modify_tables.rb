class ModifyTables < ActiveRecord::Migration[6.0]
  def change

    remove_column 'gas_stations', 'price_gasoline_95_protection'
    remove_column 'gas_stations', 'price_gasoline_98'
    remove_column 'gas_stations', 'price_new_diesel_a'



    add_column 'gas_stations', 'price_gasoline_95_e10', :string
    add_column 'gas_stations', 'price_gasoline_95_e5', :string
    add_column 'gas_stations', 'price_gasoline_95_e5_premium', :string
    add_column 'gas_stations', 'price_gasoline_98_e10', :string
    add_column 'gas_stations', 'price_gasoline_98_e5', :string
    add_column 'gas_stations', 'price_diesel_premium', :string




  end
end
