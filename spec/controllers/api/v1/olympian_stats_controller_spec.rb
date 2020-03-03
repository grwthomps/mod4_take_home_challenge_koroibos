require 'rails_helper'

RSpec.describe Api::V1::OlympianStatsController, type: :controller do
  before(:each) do
    egypt = Team.create(country: "Egypt")
    philippines = Team.create(country: "Philippines")
    bulgaria = Team.create(country: "Bulgaria")
    vietnam = Team.create(country: "Vietnam")

    golf = Sport.create(name: "Golf")
    wrestling = Sport.create(name: "Wrestling")
    gymnastics = Sport.create(name: "Gymnastics")

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
  end

  describe "get stats for all olympians", :type => :request do
    before(:each) do
      get '/api/v1/olympian_stats'
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end

    it 'has all stats present' do
      expect(JSON.parse(response.body)["olympian_stats"]["total_competing_olympians"]).not_to be_nil
      expect(JSON.parse(response.body)["olympian_stats"]["average_weight"]).not_to be_nil
      expect(JSON.parse(response.body)["olympian_stats"]["average_weight"]["unit"]).not_to be_nil
      expect(JSON.parse(response.body)["olympian_stats"]["average_weight"]["male_olympians"]).not_to be_nil
      expect(JSON.parse(response.body)["olympian_stats"]["average_weight"]["female_olympians"]).not_to be_nil
      expect(JSON.parse(response.body)["olympian_stats"]["average_age"]).not_to be_nil
    end

    it 'has correct stats' do
      expect(JSON.parse(response.body)["olympian_stats"]["total_competing_olympians"]).to eq(5)
      expect(JSON.parse(response.body)["olympian_stats"]["average_weight"]["unit"]).to eq("kg")
      expect(JSON.parse(response.body)["olympian_stats"]["average_weight"]["male_olympians"]).to eq(74.0)
      expect(JSON.parse(response.body)["olympian_stats"]["average_weight"]["female_olympians"]).to eq(57.7)
      expect(JSON.parse(response.body)["olympian_stats"]["average_age"]).to eq(21.6)
    end
  end
end
