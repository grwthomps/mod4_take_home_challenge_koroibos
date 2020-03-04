class Team < ApplicationRecord
  has_many :olympians

  validates_presence_of :country
  validates_uniqueness_of :country
end
