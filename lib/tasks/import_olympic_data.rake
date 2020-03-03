desc "import olympic data from csv file"
task import_olympic_data: [:environment] do
  require 'csv'

  CSV.foreach('olympians.csv', headers: true) do |row|
    team = Team.find_or_create_by(country: row["Team"].split("-")[0])

    sport = Sport.find_or_create_by(name: row["Sport"])

    event = Event.find_or_create_by(name: row["Event"], sport_id: sport.id)

    olympian = Olympian.find_or_create_by(
      name: row["Name"],
      sex: row["Sex"],
      age: row["Age"].to_i,
      height: row["Height"].to_i,
      weight: row["Weight"].to_i,
      team_id: team.id,
      sport_id: sport.id
    )

    OlympianEvent.find_or_create_by(
      olympian_id: olympian.id,
      event_id: event.id,
      medal: row["Medal"]
    )
  end
end
