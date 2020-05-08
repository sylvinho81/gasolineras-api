require 'rails_helper'


RSpec.describe GasStationsController, type: :controller do




  describe "GET #index" do
    setup do
      FactoryBot.create :gasstation_embajadores
      FactoryBot.create :gasstation_acacias
      FactoryBot.create :gasstation_lugo
    end

    context "the geolocation is not activated and we don't receive lat and long" do
      before do
        get :index
      end

      it "JSON body response contains gas stations near to Puerta del Sol, Madrid" do
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




    context "the geolocation is activated and our coordinates are 43.037656, -7.568899 Avenida Infanta Elena Duquesa de Lugo, S/ N" do
      before do
        params = {:lat=>"43.037656", :long=>"-7.568899", format: :json}
        get :index, params: params
      end

      it "JSON body response contains gas stations near to that location" do
        expect(json["gas_stations"].size) == 1
      end
    end
  end


  describe "GET #search" do
    setup do
      FactoryBot.create :gasstation_embajadores
      FactoryBot.create :gasstation_acacias
      FactoryBot.create :gasstation_lugo
    end

    context "the user uses the search field and enter Lugo and click on button 'Buscar'" do
      before do
        params = {:q => "Lugo", format: :json}
        get :index, params: params
      end

      it "JSON body response contains gas stations near to Lugo" do
        expect(json["gas_stations"].size) == 1
      end
    end


  end



end