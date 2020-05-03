require 'rails_helper'

RSpec.describe GasStation, type: :model do


  subject(:gas_station) {GasStation.new(latitude: 40.416729, address: "CAMINO MARTINETE, 52", label: "EASYGAS", ideess: 100)}

  before {gas_station.save}

  it "longitude should be present" do
    expect(gas_station).to_not be_valid
  end

  it "address should be present" do
    subject.address = nil
    expect(gas_station).to_not be_valid
  end

  it "label should be present" do
    subject.label = nil
    expect(gas_station).to_not be_valid
  end

  it "ideess should be present" do
    subject.ideess = nil
    expect(gas_station).to_not be_valid
  end

  describe ".near_by_coordinates" do

    setup do
      FactoryBot.create :gasstation_embajadores
      FactoryBot.create :gasstation_acacias
      FactoryBot.create :gasstation_lugo
    end

    context "when the coordinates of our position are 40.416729, -3.703339" do
      subject(:gas_stations) {GasStation.near_by_coordinates(latitude: 40.416729, longitude: -3.703339, page: 1) }
      it { expect(gas_stations.size).to be 2 }
      it { expect(gas_stations).to include FactoryBot.build(:gasstation_embajadores)}
      it { expect(gas_stations).not_to include FactoryBot.build(:gasstation_lugo)}
    end

  end
end

