require 'rails_helper'

RSpec.describe Api::V1::EventsController, type: :controller do
  describe "events index endpoint" do
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

  describe "events show endpoint" do
    before(:each) do
      egypt = Team.create(country: "Egypt")
      bulgaria = Team.create(country: "Bulgaria")
      botswana = Team.create(country: "Botswana")

      golf = Sport.create(name: "Golf")
      boxing = Sport.create(name: "Boxing")

      dorothy = Olympian.create(
        name: "Dorothy Tucker",
        sex: "F",
        age: 18,
        weight: 48,
        height: 158,
        team_id: egypt.id,
        sport_id: golf.id
      )

      freddie = Olympian.create(
        name: "Freddie Sanders",
        sex: "M",
        age: 23,
        weight: 80,
        height: 169,
        team_id: egypt.id,
        sport_id: golf.id
      )

      amelia = Olympian.create(
        name: "Amelia Kim",
        sex: "F",
        age: 20,
        weight: 54,
        height: 155,
        team_id: botswana.id,
        sport_id: golf.id
      )

      benjamin = Olympian.create(
        name: "Benjamin Johnston",
        sex: "M",
        age: 25,
        weight: 68,
        height: 144,
        team_id: bulgaria.id,
        sport_id: golf.id
      )

      @golf_event = Event.create(name: "Golf Event", sport_id: golf.id)
      @boxing_event = Event.create(name: "Boxing Event", sport_id: boxing.id)

      OlympianEvent.create(olympian_id: dorothy.id, event_id: @golf_event.id, medal: "NA")
      OlympianEvent.create(olympian_id: freddie.id, event_id: @golf_event.id, medal: "Silver")
      OlympianEvent.create(olympian_id: amelia.id, event_id: @golf_event.id, medal: "Gold")
      OlympianEvent.create(olympian_id: benjamin.id, event_id: @golf_event.id, medal: "Bronze")
    end

    describe "medalists by event", :type => :request do
      it 'returns status code 200' do
        get "/api/v1/events/#{@golf_event.id}/medalists"

        expect(response).to have_http_status(:success)
      end

      it 'returns event and all medalists' do
        get "/api/v1/events/#{@golf_event.id}/medalists"

        expect(JSON.parse(response.body)["event"]).to eq("Golf Event")
        expect(JSON.parse(response.body)["medalists"].size).to eq(3)
      end

      it 'has the correct medalists in the correct order' do
        get "/api/v1/events/#{@golf_event.id}/medalists"

        expect(JSON.parse(response.body)["medalists"][0]["name"]).not_to be_nil
        expect(JSON.parse(response.body)["medalists"][0]["team"]).not_to be_nil
        expect(JSON.parse(response.body)["medalists"][0]["age"]).not_to be_nil
        expect(JSON.parse(response.body)["medalists"][0]["medal"]).not_to be_nil

        expect(JSON.parse(response.body)["medalists"][1]["name"]).not_to be_nil
        expect(JSON.parse(response.body)["medalists"][1]["team"]).not_to be_nil
        expect(JSON.parse(response.body)["medalists"][1]["age"]).not_to be_nil
        expect(JSON.parse(response.body)["medalists"][1]["medal"]).not_to be_nil

        expect(JSON.parse(response.body)["medalists"][2]["name"]).not_to be_nil
        expect(JSON.parse(response.body)["medalists"][2]["team"]).not_to be_nil
        expect(JSON.parse(response.body)["medalists"][2]["age"]).not_to be_nil
        expect(JSON.parse(response.body)["medalists"][2]["medal"]).not_to be_nil
      end

      it 'has a response when there are no medalists' do
        get "/api/v1/events/#{@boxing_event.id}/medalists"

        expect(JSON.parse(response.body)["event"]).to eq("Boxing Event")
        expect(JSON.parse(response.body)["medalists"].size).to eq(0)
      end
    end
  end
end
