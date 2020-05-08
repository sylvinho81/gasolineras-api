require 'rails_helper'


RSpec.describe GasStationsController, type: :controller do

  describe "GET #index" do

    setup do
      FactoryBot.create :gasstation_embajadores
      FactoryBot.create :gasstation_acacias
      FactoryBot.create :gasstation_lugo
    end

    before do
      get :index
    end

    context "the geolocation is not activated and we don't receive lat and long" do
      it "JSON body response contains gas stations near to Puerta del Sol" do
        json_response = JSON.parse(response.body)
        expect(json_response["gas_stations"].size).to be 2
      end

      it "JSON body response contains the attribute type_search 'coordinates'" do
        json_response = JSON.parse(response.body)
        expect(json_response["type_search"]).to eq "coordinates"
      end
    end


  end



end