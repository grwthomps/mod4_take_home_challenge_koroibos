class Team < ApplicationRecord
  validates_presence_of :country
  validates_uniqueness_of :country
end
