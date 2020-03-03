require 'rails_helper'

RSpec.describe Olympian, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }

    it { should validate_presence_of(:sex) }

    it { should validate_presence_of(:age) }
    it { should validate_numericality_of(:age) }

    it { should validate_presence_of(:height) }
    it { should validate_numericality_of(:height) }

    it { should validate_presence_of(:weight) }
    it { should validate_numericality_of(:weight) }
  end

  describe 'methods' do
    before(:each) do
      egypt = Team.create!(country: "Egypt")
      vietnam = Team.create!(country: "Vietnam")

      golf = Sport.create!(name: "Golf")
      gymnastics = Sport.create!(name: "Gymnastics")

      @dorothy = Olympian.create!(
        name: "Dorothy Tucker",
        sex: "F",
        age: 18,
        weight: 48,
        height: 158,
        team_id: egypt.id,
        sport_id: golf.id
      )

      @cheyenne = Olympian.create!(
        name: "Cheyenne Song",
        sex: "F",
        age: 22,
        weight: 71,
        height: 157,
        team_id: vietnam.id,
        sport_id: gymnastics.id
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

      @benjamin = Olympian.create(
        name: "Benjamin Johnston",
        sex: "M",
        age: 25,
        weight: 68,
        height: 144,
        team_id: vietnam.id,
        sport_id: gymnastics.id
      )

      golf_event = Event.create!(name: "Golf Event", sport_id: golf.id)
      golf_event_2 = Event.create!(name: "Golf Event 2", sport_id: golf.id)
      gymnastics_event = Event.create!(name: "Gymnastics Event", sport_id: gymnastics.id)

      OlympianEvent.create!(olympian_id: @dorothy.id, event_id: golf_event.id, medal: "Bronze")
      OlympianEvent.create!(olympian_id: @dorothy.id, event_id: golf_event_2.id, medal: "NA")
      OlympianEvent.create!(olympian_id: @cheyenne.id, event_id: gymnastics_event.id, medal: "NA")
    end

    it "can calculate total medals won" do
      expect(@dorothy.total_medals_won).to eq(1)
      expect(@cheyenne.total_medals_won).to eq(0)
    end

    it "can calculate youngest olympian" do
      expect(Olympian.youngest).to eq(@dorothy)
    end

    it "can calculate oldest olympian" do
      expect(Olympian.oldest).to eq(@benjamin)
    end

    it "can calculate total competing olympians" do
      expect(Olympian.total_competing).to eq(4)
    end

    it "can calculate average olympian weights" do
      expect(Olympian.average_weight("M")).to eq(74.0)
      expect(Olympian.average_weight("F")).to eq(59.5)
    end

    it "can calculate average olympian age" do
      expect(Olympian.average_age).to eq(22.0)
    end
  end
end
