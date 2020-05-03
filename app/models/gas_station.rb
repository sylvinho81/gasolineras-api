class GasStation < ApplicationRecord

  self.primary_key = :ideess
  self.per_page = 16

  PROXIMITY_RADIUS_KM = 20

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  validates_presence_of :latitude
  validates_presence_of :longitude
  validates_presence_of :address
  validates_presence_of :label
  validates_presence_of :ideess

  def self.near_by_coordinates(latitude:, longitude:, page:)
    GasStation.near([latitude,longitude], PROXIMITY_RADIUS_KM, units: :km).paginate(page: page)
  end

end
