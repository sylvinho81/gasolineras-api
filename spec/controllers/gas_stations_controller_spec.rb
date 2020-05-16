require 'rails_helper'


RSpec.describe GasStationsController, type: :controller do




  describe "GET #index" do
    setup do
      FactoryBot.create :gasstation_embajadores
      FactoryBot.create :gasstation_acacias
      FactoryBot.create :gasstation_lugo
    end

    keys_response_index = ["gas_stations", "page", "pages", "latitude", "longitude", "type_search", "type_fuel"]

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

      it "JSON body response contains specific keys: #{keys_response_index.join(',')}" do
        expect(json.keys).to eq keys_response_index
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
        expect(json["gas_stations"].size).to eq 1
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
        get :search, params: params
      end

      it "JSON body response contains gas stations near to Lugo" do
        expect(json["gas_stations"].size).to eq(1)
      end

      it "JSON body response coordinates should match with the coordinates([43.0462247,-7.4739921]) of the first place returned by Geocoder plugin" do
        expect(json["latitude"]).to eq 43.0462247
        expect(json["longitude"]).to eq -7.4739921
      end
    end
  end



  describe "GET#autocomplete" do
    context "the user types 'madrid' in the search input file" do
      before do
        params = {:q => "madrid", format: :json}
        get :autocomplete, params: params
      end

      it "JSON body response contains specific keys" do
        expect(json.keys).to eq ["suggestions", "coordinates"]
      end

      it "JSON body response suggestions is an array with the suggested gas stations" do
        expect(json["suggestions"]).to be_a_kind_of(Array)
      end

      it "JSON body response coordinates is an array with the coordinates of the suggested gas stations" do
        expect(json["coordinates"]).to be_a_kind_of(Array)
      end
    end
  end



  describe "GET#by_province" do
    setup do
      FactoryBot.create :gasstation_embajadores
      FactoryBot.create :gasstation_acacias
      FactoryBot.create :gasstation_lugo
    end

    context "the user types '/gasolineras-en-lugo' in the browser" do
      before do
        params = {:province => "lugo", format: :json}
        get :by_province, params: params
      end

      it "JSON body response contains gas stations near to Lugo" do
        expect(json["gas_stations"].size).to eq(1)
      end
    end


    context "the user types '/gasolineras-en-granada' in the browser" do
      before do
        params = {:province => "granada", format: :json}
        get :by_province, params: params
      end

      it "JSON body response doesn't contain gas stations near to Granada" do
        expect(json["gas_stations"].size).to eq(0)
      end
    end
  end


end