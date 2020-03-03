class FormatOlympians
  def self.result(age)
    if age.nil?
      all_olympians
    elsif age == "youngest"
      single_olympian(Olympian.youngest)
    elsif age == "oldest"
      single_olympian(Olympian.oldest)
    end
  end

  private

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

  def self.single_olympian(olympian)
    [{
      "name": olympian.name,
      "team": olympian.team.country,
      "age": olympian.age,
      "sport": olympian.sport.name,
      "total_medals_won": olympian.total_medals_won
    }]
  end
end
