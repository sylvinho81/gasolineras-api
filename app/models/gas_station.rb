require 'rest-client'
require 'json'

class GasStation < ApplicationRecord

  self.primary_key = :ideess
  self.per_page = 16

  PROXIMITY_RADIUS_KM = 20
  PROXIMITY_RADIUS_KM_FILTER_BY_FUEL = 10


  MAPPINGS_GOB_API = { 'C.P.' => 'cp',
                       'Dirección' => 'address',
                       'Horario' =>  'schedule',
                       'Latitud' => 'latitude',
                       'Localidad' => 'location',
                       'Longitud (WGS84)' => 'longitude',
                       'Margen' => 'margin',
                       'Municipio' => 'municipality',
                       'Precio Biodiesel' => 'price_biodiesel',
                       'Precio Bioetanol' => 'price_bioethanol',
                       'Precio Gas Natural Comprimido' => 'price_compressed_natural_gas',
                       'Precio Gas Natural Licuado' => 'price_liquefied_natural_gas',
                       'Precio Gases licuados del petróleo' => 'price_liquefied_petroleum_gases',
                       'Precio Gasoleo A' => 'price_diesel_a',
                       'Precio Gasoleo B' => 'price_diesel_b',
                       'Precio Gasolina 95 E10' => 'price_gasoline_95_e10',
                       'Precio Gasolina 95 E5' => 'price_gasoline_95_e5',
                       'Precio Gasolina 95 E5 Premium' => 'price_gasoline_95_e5_premium',
                       'Precio Gasolina 98 E10' => 'price_gasoline_98_e10',
                       'Precio Gasolina 98 E5' => 'price_gasoline_98_e5',
                       'Precio Gasoleo Premium' => 'price_diesel_premium',
                       'Provincia' => 'province',
                       'Remisión' => 'remission',
                       'Rótulo' => 'label',
                       'Tipo Venta' => 'sale_type',
                       '% BioEtanol' => 'bioethanol',
                       '% Éster metílico' => 'methyl_ester',
                       'IDEESS' => 'ideess',
                       'IDMunicipio' => 'id_municipality',
                       'IDProvincia' => 'id_province',
                       'IDCCAA' => 'idccaa'

  }

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  validates_presence_of :latitude
  validates_presence_of :longitude
  validates_presence_of :address
  validates_presence_of :label
  validates_presence_of :ideess



  def self.near_by_coordinates(latitude:, longitude:, page:, type_fuel: 'all')
    if type_fuel == 'all'
      GasStation.near([latitude,longitude], PROXIMITY_RADIUS_KM, units: :km).paginate(page: page)
    else
      GasStation.where("#{type_fuel} is NOT NULL").order("#{type_fuel} asc").near([latitude,longitude], PROXIMITY_RADIUS_KM_FILTER_BY_FUEL, units: :km).paginate(page: page)
    end
  end





  def self.import_gas_stations(url_api)
    RestClient.get(url_api, {accept: :json}) { |response, request, result|
      if response.code ==  200
        results = JSON.parse(response.to_str)

        list_gas_stations = results['ListaEESSPrecio']


        puts(list_gas_stations)
        new_list = list_gas_stations.map {|gas_station|
          gas_station.transform_keys(&MAPPINGS_GOB_API.method(:[])).merge!(updated_at: results['Fecha'])
        }

        new_list_formatted = new_list.map {|gas_station|
          gas_station.merge!(latitude: gas_station["latitude"].gsub(",", "."), longitude: gas_station["longitude"].gsub(",", "."))
        }

        GasStation.upsert_all(new_list_formatted, unique_by: :ideess)

      else
        Rails.logger.info("Error calling sedeaplicaciones.minetur.gob.es")
      end
    }
  end

end


# Example json response
=begin
            {
              "Fecha":"Contenido de la cadena",
              "ListaEESSPrecio":[{
                "C.P.":"Contenido de la cadena",
                "Dirección":"Contenido de la cadena",
                "Horario":"Contenido de la cadena",
                "Latitud":"Contenido de la cadena",
                "Localidad":"Contenido de la cadena",
                "Longitud_x0020__x0028_WGS84_x0029_":"Contenido de la cadena",
                "Margen":"Contenido de la cadena",
                "Municipio":"Contenido de la cadena",
                "Precio_x0020_Biodiesel":"Contenido de la cadena",
                "Precio_x0020_Bioetanol":"Contenido de la cadena",
                "Precio_x0020_Gas_x0020_Natural_x0020_Comprimido":"Contenido de la cadena",
                "Precio_x0020_Gas_x0020_Natural_x0020_Licuado":"Contenido de la cadena",
                "Precio_x0020_Gases_x0020_licuados_x0020_del_x0020_petróleo":"Contenido de la cadena",
                "Precio_x0020_Gasoleo_x0020_A":"Contenido de la cadena",
                "Precio_x0020_Gasoleo_x0020_B":"Contenido de la cadena",
                "Precio_x0020_Gasolina_x0020_95_x0020_Protección":"Contenido de la cadena",
                "Precio_x0020_Gasolina_x0020__x0020_98":"Contenido de la cadena",
                "Precio_x0020_Nuevo_x0020_Gasoleo_x0020_A":"Contenido de la cadena",
                "Provincia":"Contenido de la cadena",
                "Remisión":"Contenido de la cadena",
                "Rótulo":"Contenido de la cadena",
                "Tipo_x0020_Venta":"Contenido de la cadena",
                "_x0025__x0020_BioEtanol":"Contenido de la cadena",
                "_x0025__x0020_Éster_x0020_metílico":"Contenido de la cadena",
                "IDEESS":"Contenido de la cadena",
                "IDMunicipio":"Contenido de la cadena",
                "IDProvincia":"Contenido de la cadena",
                "IDCCAA":"Contenido de la cadena"
              }],
              "Nota":"Contenido de la cadena",
              "ResultadoConsulta":"Contenido de la cadena"
            }
=end
