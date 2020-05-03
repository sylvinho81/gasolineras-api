FactoryBot.define do
  factory :gasstation_embajadores, class: GasStation do
    ideess {1}
    latitude {40.405278}
    longitude {-3.703139}
    address {"GLORIETA EMBAJADORES, 0"}
    label {"CEPSA"}
  end

  factory :gasstation_acacias, class: GasStation do
    ideess {2}
    latitude  {40.404417}
    longitude {-3.705389}
    address  {"CL PASEO ACACIAS, 8"}
    label {"REPSOL"}
  end


  factory :gasstation_lugo, class: GasStation do
    ideess {3}
    latitude  {43.045472}
    longitude {-7.560694}
    address { "POLIGONO RUA MERCADURIAS, 218 PG. CEAO, 218"}
    label {"CONFORT AUTO"}
  end
end