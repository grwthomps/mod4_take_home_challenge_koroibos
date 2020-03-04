class FormatEvents
  def self.all_events
    Sport.order(:name).map do |sport|
      {
        "sport": sport.name,
        "events": get_event_names(sport)
      }
    end
  end

  def self.by_medalists(id)
    event = Event.find(id)
    medalists = event.find_medalists

    if !medalists.empty?
      medalists = format_medalists(medalists)
    end

    {
      "event": event.name,
      "medalists": medalists
    }
  end

  private

  def self.get_event_names(sport)
    sport.events.order(:name).map do |event|
      event.name
    end
  end

  def self.format_medalists(medalists)
    medalists.map do |medalist|
      {
        "name": medalist.olympian.name,
        "team": medalist.olympian.team.country,
        "age": medalist.olympian.age,
        "medal": medalist.medal
      }
    end
  end
end
