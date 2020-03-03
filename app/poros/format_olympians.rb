class FormatOlympians
  def self.all_olympians
    Olympian.all.map do |olympian|
      {
        "name": olympian.name,
        "team": olympian.team.country,
        "age": olympian.age,
        "sport": olympian.sport.name,
        "total_medals_won": olympian.total_medals_won
      }
    end
  end
end
