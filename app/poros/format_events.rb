class FormatEvents
  def self.all_events
    Sport.order(:name).map do |sport|
      {
        "sport": sport.name,
        "events": get_event_names(sport)
      }
    end
  end

  def self.get_event_names(sport)
    sport.events.order(:name).map do |event|
      event.name
    end
  end
end
