# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_23_193022) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "gas_stations", id: false, force: :cascade do |t|
    t.string "cp"
    t.string "address"
    t.string "schedule"
    t.float "latitude"
    t.string "location"
    t.float "longitude"
    t.string "margin"
    t.string "municipality"
    t.string "price_biodiesel"
    t.string "price_bioethanol"
    t.string "price_compressed_natural_gas"
    t.string "price_liquefied_natural_gas"
    t.string "price_liquefied_petroleum_gases"
    t.string "price_diesel_a"
    t.string "price_diesel_b"
    t.string "province"
    t.string "remission"
    t.string "label"
    t.string "sale_type"
    t.string "bioethanol"
    t.string "methyl_ester"
    t.integer "ideess"
    t.string "id_municipality"
    t.string "id_province"
    t.string "idccaa"
    t.datetime "updated_at"
    t.string "price_gasoline_95_e10"
    t.string "price_gasoline_95_e5"
    t.string "price_gasoline_95_e5_premium"
    t.string "price_gasoline_98_e10"
    t.string "price_gasoline_98_e5"
    t.string "price_diesel_premium"
    t.index ["ideess"], name: "index_gas_stations_on_ideess", unique: true
    t.index ["latitude", "longitude"], name: "index_gas_stations_on_latitude_and_longitude"
  end

end
