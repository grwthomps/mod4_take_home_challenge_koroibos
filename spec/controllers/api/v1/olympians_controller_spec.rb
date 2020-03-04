require 'rails_helper'

RSpec.describe Api::V1::OlympiansController, type: :controller do
  before(:each) do
    egypt = Team.create(country: "Egypt")
    philippines = Team.create(country: "Philippines")
    bulgaria = Team.create(country: "Bulgaria")
    vietnam = Team.create(country: "Vietnam")
    japan = Team.create(country: "Japan")
    botswana = Team.create(country: "Botswana")

    golf = Sport.create(name: "Golf")
    wrestling = Sport.create(name: "Wrestling")
    gymnastics = Sport.create(name: "Gymnastics")
    weightlifting = Sport.create(name: "Weightlifting")
    fencing = Sport.create(name: "Fencing")

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
      team_id: philippines.id,
      sport_id: wrestling.id
    )

    benjamin = Olympian.create(
      name: "Benjamin Johnston",
      sex: "M",
      age: 25,
      weight: 68,
      height: 144,
      team_id: bulgaria.id,
      sport_id: wrestling.id
    )

    cheyenne = Olympian.create(
      name: "Cheyenne Song",
      sex: "F",
      age: 22,
      weight: 71,
      height: 157,
      team_id: vietnam.id,
      sport_id: gymnastics.id
    )

    deandre = Olympian.create(
      name: "Deandrea Smiley",
      sex: "F",
      age: 24,
      weight: 56,
      height: 154,
      team_id: vietnam.id,
      sport_id: weightlifting.id
    )

    kathryn = Olympian.create(
      name: "Kathyrn Childers",
      sex: "F",
      age: 21,
      weight: 52,
      height: 160,
      team_id: japan.id,
      sport_id: gymnastics.id
    )

    rob = Olympian.create(
      name: "Rob Finney",
      sex: "M",
      age: 27,
      weight: 80,
      height: 179,
      team_id: japan.id,
      sport_id: fencing.id
    )

    eddie = Olympian.create(
      name: "Eddie Holiday",
      sex: "M",
      age: 25,
      weight: 60,
      height: 183,
      team_id: botswana.id,
      sport_id: weightlifting.id
    )

    jennifer = Olympian.create(
      name: "Jennifer Mcvay",
      sex: "F",
      age: 30,
      weight: 57,
      height: 179,
      team_id: botswana.id,
      sport_id: fencing.id
    )

    golf_event = Event.create(name: "Golf Event", sport_id: golf.id)
    golf_event_2 = Event.create(name: "Golf Event 2", sport_id: golf.id)
    wrestling_event = Event.create(name: "Wrestling Event", sport_id: wrestling.id)
    gymnastics_event = Event.create(name: "Gymnastics Event", sport_id: gymnastics.id)
    weightlifting_event = Event.create(name: "Weightlifting Event", sport_id: weightlifting.id)
    fencing_event = Event.create(name: "Fencing Event", sport_id: fencing.id)

    OlympianEvent.create(olympian_id: dorothy.id, event_id: golf_event.id, medal: "Bronze")
    OlympianEvent.create(olympian_id: dorothy.id, event_id: golf_event_2.id, medal: "NA")
    OlympianEvent.create(olympian_id: freddie.id, event_id: golf_event_2.id, medal: "Gold")
    OlympianEvent.create(olympian_id: amelia.id, event_id: wrestling_event.id, medal: "Silver")
    OlympianEvent.create(olympian_id: benjamin.id, event_id: wrestling_event.id, medal: "Bronze")
    OlympianEvent.create(olympian_id: cheyenne.id, event_id: gymnastics_event.id, medal: "NA")
    OlympianEvent.create(olympian_id: deandre.id, event_id: weightlifting_event.id, medal: "Gold")
    OlympianEvent.create(olympian_id: kathryn.id, event_id: gymnastics_event.id, medal: "Gold")
    OlympianEvent.create(olympian_id: rob.id, event_id: fencing_event.id, medal: "NA")
    OlympianEvent.create(olympian_id: eddie.id, event_id: weightlifting_event.id, medal: "Silver")
    OlympianEvent.create(olympian_id: jennifer.id, event_id: fencing_event.id, medal: "Silver")
  end

  describe "get all olympians", :type => :request do
    before(:each) do
      get '/api/v1/olympians'
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end

    it 'returns all olympians' do
      parsed_response = JSON.parse(response.body)

      expect(parsed_response["olympians"].size).to eq(10)
    end

    it 'has the correct attributes' do
      parsed_response = JSON.parse(response.body)

      expect(parsed_response["olympians"].first["name"]).not_to be_nil
      expect(parsed_response["olympians"].first["team"]).not_to be_nil
      expect(parsed_response["olympians"].first["age"]).not_to be_nil
      expect(parsed_response["olympians"].first["sport"]).not_to be_nil
      expect(parsed_response["olympians"].first["total_medals_won"]).not_to be_nil

      expect(parsed_response["olympians"].first["sex"]).to be_nil
      expect(parsed_response["olympians"].first["height"]).to be_nil
      expect(parsed_response["olympians"].first["weight"]).to be_nil
    end
  end

  describe "get youngest olympian by passing age paramater", :type => :request do
    before(:each) do
      get '/api/v1/olympians?age=youngest'
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end

    it 'does not return multiple olympians' do
      parsed_response = JSON.parse(response.body)

      expect(parsed_response["olympians"].size).to eq(1)
    end

    it 'returns youngest olympian' do
      parsed_response = JSON.parse(response.body)

      expect(parsed_response["olympians"].first["name"]).to eq("Dorothy Tucker")
      expect(parsed_response["olympians"].first["team"]).to eq("Egypt")
      expect(parsed_response["olympians"].first["age"]).to eq(18)
      expect(parsed_response["olympians"].first["sport"]).to eq("Golf")
      expect(parsed_response["olympians"].first["total_medals_won"]).to eq(1)
    end
  end

  describe "get oldest olympian by passing age paramater", :type => :request do
    before(:each) do
      get '/api/v1/olympians?age=oldest'
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end

    it 'does not return multiple olympians' do
      parsed_response = JSON.parse(response.body)

      expect(parsed_response["olympians"].size).to eq(1)
    end

    it 'returns youngest olympian' do
      parsed_response = JSON.parse(response.body)

      expect(parsed_response["olympians"].first["name"]).to eq("Jennifer Mcvay")
      expect(parsed_response["olympians"].first["team"]).to eq("Botswana")
      expect(parsed_response["olympians"].first["age"]).to eq(30)
      expect(parsed_response["olympians"].first["sport"]).to eq("Fencing")
      expect(parsed_response["olympians"].first["total_medals_won"]).to eq(1)
    end
  end
end
