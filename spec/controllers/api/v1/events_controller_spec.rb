require 'rails_helper'

RSpec.describe Api::V1::EventsController, type: :controller do
  before(:each) do
    golf = Sport.create(name: "Golf")
    gymnastics = Sport.create(name: "Gymnastics")
    weightlifting = Sport.create(name: "Weightlifting")
    fencing = Sport.create(name: "Fencing")

    Event.create(name: "Second Golf Event", sport_id: golf.id)
    Event.create(name: "First Golf Event", sport_id: golf.id)
    Event.create(name: "Weightlifting Event", sport_id: weightlifting.id)
    Event.create(name: "Second Fencing Event", sport_id: fencing.id)
    Event.create(name: "First Fencing Event", sport_id: fencing.id)
  end

  describe "get all events", :type => :request do
    before(:each) do
      get '/api/v1/events'
    end

    it 'returns all events' do
      expect(JSON.parse(response.body)["events"].size).to eq(4)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end

    it 'has the correct events in the correct order' do
      expect(JSON.parse(response.body)["events"][0]["sport"]).to eq("Fencing")
      expect(JSON.parse(response.body)["events"][0]["events"][0]).to eq("First Fencing Event")
      expect(JSON.parse(response.body)["events"][0]["events"][1]).to eq("Second Fencing Event")

      expect(JSON.parse(response.body)["events"][1]["sport"]).to eq("Golf")
      expect(JSON.parse(response.body)["events"][1]["events"][0]).to eq("First Golf Event")
      expect(JSON.parse(response.body)["events"][1]["events"][1]).to eq("Second Golf Event")

      expect(JSON.parse(response.body)["events"][2]["sport"]).to eq("Gymnastics")
      expect(JSON.parse(response.body)["events"][2]["events"].count).to eq(0)

      expect(JSON.parse(response.body)["events"][3]["sport"]).to eq("Weightlifting")
      expect(JSON.parse(response.body)["events"][3]["events"][0]).to eq("Weightlifting Event")
    end
  end
end
