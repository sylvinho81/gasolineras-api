class GasStationsController < ApplicationController
  before_action :set_gas_station, only: [:show]
  before_action :set_page, only: [:index, :search]

  # GET /gas_stations
  def index
    latitude =  params[:lat].present? ?  params[:lat] : 40.416729
    longitude = params[:long].present? ?  params[:long] : -3.703339
    @gas_stations = GasStation.near_by_coordinates(latitude: latitude.to_f, longitude: longitude.to_f, page: @page)
    render json: { gas_stations: @gas_stations,
                   page: @gas_stations.current_page - 1,
                   pages: @gas_stations.total_pages,
                   latitude: latitude,
                   longitude: longitude,
                   type_search: 'coordinates'

    }
  end

  # GET /gas_stations/1
  def show
    render json: @gas_station
  end


  def search
    q = params[:q]
    lat = params[:lat].try(:to_f)
    lon = params[:lon].try(:to_f)

    first_suggestion = lat.present? && lon.present? ?
                           Geocoder.search([lat, lon], params: {countrycodes: "es"}).first :
                           Geocoder.search(q, params: {countrycodes: "es"}).first
    response = {  gas_stations: [],
                  page: 0,
                  pages: 0,
                  input_search: q,
                  latitude: 0,
                  longitude: 0,
                  type_search: lat.present? && lon.present? ? 'coordinates' : 'normal' }
    if first_suggestion.present?
      latitude =  first_suggestion.coordinates.first
      longitude = first_suggestion.coordinates.second
      @gas_stations = GasStation.near_by_coordinates(latitude: latitude,longitude: longitude, page: @page)
      response.merge!(gas_stations: @gas_stations, page: @gas_stations.current_page - 1, pages: @gas_stations.total_pages, latitude: lat || 0, longitude: lon || 0)
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


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gas_station
      @gas_station = GasStation.find(params[:id])
    end

    def set_page
      @page = params[:page].present? ? params[:page].to_i + 1 : 1
    end


end
