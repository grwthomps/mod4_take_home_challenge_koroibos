class Olympian < ApplicationRecord
  validates_presence_of :name,
                        :sex,
                        :age,
                        :height,
                        :weight,
                        :team,
                        :games,
                        :sport,
                        :event,
                        :medal

  validates_numericality_of :age
  validates_numericality_of :height
  validates_numericality_of :weight
end
