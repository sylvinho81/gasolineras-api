class GasStationsController < ApplicationController
  before_action :set_gas_station, only: [:show]
  before_action :set_page, only: [:index, :search, :by_province]

  # GET /gas_stations
  def index
    latitude =  params[:lat].present? ?  params[:lat] : 40.416729
    longitude = params[:long].present? ?  params[:long] : -3.703339
    type_fuel = params[:radio] || 'all'
    @gas_stations = GasStation.near_by_coordinates(latitude: latitude.to_f, longitude: longitude.to_f, page: @page, type_fuel: type_fuel)
    render json: { gas_stations: @gas_stations,
                   page: @gas_stations.current_page - 1,
                   pages: @gas_stations.total_pages,
                   latitude: latitude,
                   longitude: longitude,
                   type_search: 'coordinates',
                   type_fuel: type_fuel


    }
  end

  # GET /gas_stations/1
  def show
    render json: @gas_station
  end


  def search
    q = params[:q]
    Rails.logger.info "Input search #{q}"
    lat = params[:lat].try(:to_f)
    lon = params[:lon].try(:to_f)
    type_fuel = params[:radio] || 'all'
    type_search = lat.present? && lon.present? ? 'coordinates' : 'normal'

    response = build_response(input_search: q, type_search: type_search, type_fuel: type_fuel)

    first_suggestion = if lat.present? && lon.present?
                         Geocoder.search([lat, lon], params: {countrycodes: "es"}).first
                       else
                         Geocoder.search(q, params: {countrycodes: "es"}).first
                       end
    if first_suggestion.present?
      latitude =  first_suggestion.coordinates.first
      longitude = first_suggestion.coordinates.second
      @gas_stations = GasStation.near_by_coordinates(latitude: latitude,longitude: longitude, page: @page, type_fuel: type_fuel)

      response = build_response(gas_stations: @gas_stations,
                                page: @gas_stations.current_page - 1,
                                pages:  @gas_stations.total_pages,
                                input_search: q,
                                latitude: lat || latitude,
                                longitude: lon || longitude,
                                type_search: type_search,
                                type_fuel: type_fuel)

    end

    render json: response
  end

  def autocomplete
    q = params[:q]
    locations = Geocoder.search(q, params: {countrycodes: "es"})
    @suggestions = locations.map {|location| location.address}.uniq
    @coordinates = locations.map {|location| [location.coordinates.first, location.coordinates.second]}.uniq
    render json: { suggestions: @suggestions,
                   coordinates: @coordinates
                 }
  end


  def by_province
    province = params[:province]
    @gas_stations = GasStation.where("LOWER(province) = ?", province.downcase).paginate(page: @page)
    render json: { gas_stations: @gas_stations,
                   page: @gas_stations.current_page - 1,
                   pages:  @gas_stations.total_pages,
                  }
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gas_station
      @gas_station = GasStation.find(params[:id])
    end

    def set_page
      @page = params[:page].present? ? params[:page].to_i + 1 : 1
    end

    def build_response(gas_stations: [], page: 0, pages: 0, input_search: '', latitude: 0, longitude: 0, type_search: 'coordinates', type_fuel: 'all')
      {  gas_stations: gas_stations,
         page: page,
         pages:  pages,
         input_search: input_search,
         latitude: latitude,
         longitude: longitude,
         type_search: type_search,
         type_fuel: type_fuel}

    end
end
