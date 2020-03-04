class Event < ApplicationRecord
  belongs_to :sport

  has_many :olympian_events
  has_many :olympians, through: :olympian_events

  validates_presence_of :name
  validates_uniqueness_of :name

  def find_medalists
    olympian_events.where(event_id: id).where.not(medal: "NA")
  end
end
