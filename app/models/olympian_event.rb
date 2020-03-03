class OlympianEvent < ApplicationRecord
  belongs_to :olympian
  belongs_to :event

  validates_presence_of :medal
end
