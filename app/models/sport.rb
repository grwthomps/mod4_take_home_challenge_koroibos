class Sport < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name
end
