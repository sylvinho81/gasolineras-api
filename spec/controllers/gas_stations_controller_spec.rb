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
        expect(json["gas_stations"].size).to be 2
      end

      it "JSON body response contains the attribute type_search 'coordinates'" do
        expect(json["type_search"]).to eq "coordinates"
      end

      it "JSON body response contains specific keys" do
        expect(json.keys).to eq ["gas_stations", "page", "pages", "latitude", "longitude", "type_search"]
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end


  end



end