class Sport < ApplicationRecord
  has_many :events
  has_many :olympians

  validates_presence_of :name
  validates_uniqueness_of :name
end
